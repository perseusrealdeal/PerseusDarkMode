//
//  AppearanceService.swift
//  PerseusDarkMode
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright (c) 7530 - 7531 Mikhail Zhigulin of Novosibirsk.
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

#if os(iOS)
public typealias Responder = UIResponder
#elseif os(macOS)
public typealias Responder = NSResponder
#endif

/// Name of make up notification.
public extension Notification.Name {
    static let MakeAppearanceUpNotification = Notification.Name("MakeAppearanceUpNotification")
#if os(macOS)
    static let AppleInterfaceThemeChangedNotification = Notification.Name("AppleInterfaceThemeChangedNotification")
#endif
}

/// Dark Mode placed to to be accessed from any screen object of iOS (Mac Catalyst).
public extension Responder {
    var DarkMode: DarkModeProtocol { return AppearanceService.shared }
}

/// Represents service giving a control of the app's appearance.
///
/// - This service is dedicated to handle Dark Mode changing.
/// - The service is provided as a singleton across the app and used to take a cotrol of Dark Mode.
public class AppearanceService {

    // MARK: - Singleton

    /// Shared Dark Mode.
    public static var shared: DarkMode = { _ = it; return DarkMode() }()

    private static var it = { AppearanceService() }()
    private init() {
#if os(macOS)
        DistributedNotificationCenter.default.addObserver(
            self,
            selector: #selector(interfaceModeChanged),
            name: .AppleInterfaceThemeChangedNotification,
            object: nil
        )
#endif
    }

#if os(macOS)
    @objc internal func interfaceModeChanged() {
        if #available(macOS 10.14, *) {
            AppearanceService.processAppearanceOSDidChange()
        }
    }

    @available(macOS 10.14, *)
    public static var defaultDarkAppearanceOS: NSAppearance.Name = .darkAqua
    public static var defaultLightAppearanceOS: NSAppearance.Name = .aqua
#endif

    /// TRUE if Appearance.makeUp once called otherwise FALSE.
    ///
    /// Value is false by default and changed only once when Appearance.makeUp called for the first time,
    /// then always true in run time.
    public static var isEnabled: Bool { return hidden_isEnabled }

#if DEBUG // Isolated for unit testing
    /// Used for mocking NotificationCenter in unit testing.
    public static var nCenter: NotificationCenterProtocol = NotificationCenter.default
    /// Used for mocking UserDefaults in unit testing.
    public static var ud: UserDefaultsProtocol = UserDefaults.standard
#else
    /// Default NotificationCenter.
    public static var nCenter = NotificationCenter.default
    /// Default UserDefaults.
    public static var ud = UserDefaults.standard
#endif

    /// User choice for Dark Mode inside the app.
    ///
    /// The service keeps the value in UserDefaults. It effects DarkMode.StyleObservable on every change.
    public static var DarkModeUserChoice: DarkModeOption {
        get {
            // Load enum Int value

            let rawValue = ud.valueExists(forKey: DARK_MODE_USER_CHOICE_KEY) ?
                ud.integer(forKey: DARK_MODE_USER_CHOICE_KEY) :
                DARK_MODE_USER_CHOICE_DEFAULT.rawValue

            // Try to cast Int value to enum

            if let result = DarkModeOption.init(rawValue: rawValue) { return result }

            return DARK_MODE_USER_CHOICE_DEFAULT
        }
        set {
            ud.setValue(newValue.rawValue, forKey: DARK_MODE_USER_CHOICE_KEY)

            // Used for KVO to immediately notify a change has happened
            recalculateStyleIfNeeded()
        }
    }

    // MARK: - Public API: register stakeholder

    /// Registers stakeholders of Dark Mode.
    /// - Parameters:
    ///   - stakeholder: Stakeholder of Dark Mode.
    ///   - selector: Point to pass a control of Dark Mode.
    public static func register(stakeholder: Any, selector: Selector) {
        nCenter.addObserver(stakeholder,
                            selector: selector,
                            name: .MakeAppearanceUpNotification,
                            object: nil)
    }

    // MARK: - Public API: make the app's appearance up

    /// Calls all registered stakeholders for making up.
    ///
    /// First time should be called when didFinishLaunching happens and then every time when DarkModeUserChoice changes.
    public static func makeUp() {
        hidden_isEnabled = true
        hidden_changeManually = true

        if #available(iOS 13.0, macOS 10.14, *) { overrideUserInterfaceStyleIfNeeded() }

        recalculateStyleIfNeeded()

        nCenter.post(name: .MakeAppearanceUpNotification, object: nil)
        hidden_changeManually = false
    }

#if os(iOS)
    /// Puts the app's Dark Mode in line with System Appearance Mode.
    ///
    /// Should be called when user taggles System Appearance Mode in Settings app.
    /// Call it in override func traitCollectionDidChange in the main screen.
    ///
    /// - Parameter previousTraitCollection: Used to extract userInterfaceStyle value.
    @available(iOS 13.0, *)
    public static func processTraitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if hidden_changeManually { return }

        guard let previousSystemStyle = previousTraitCollection?.userInterfaceStyle,
              previousSystemStyle.rawValue != shared.systemStyle.rawValue
        else { return }

        hidden_systemCalledMakeUp()
    }
#elseif os(macOS)
    @available(macOS 10.14, *)
    internal static func processAppearanceOSDidChange() {
        if hidden_changeManually { return }
        hidden_systemCalledMakeUp()
    }
#endif

    // MARK: - Implementation helpers, privates and internals

    /// Used to make possible applying Black White approach in Screen design.
    private(set) static var hidden_isEnabled: Bool = false { willSet { if newValue == false { return }}}

    /// Used to reduce double calling of traitCollectionDidChange.
    internal static var hidden_changeManually: Bool = false

    /// Make up if TraitCollectionDidChange.
    internal static func hidden_systemCalledMakeUp() {
        if hidden_changeManually { return }

        hidden_isEnabled = true

        recalculateStyleIfNeeded()
        nCenter.post(name: .MakeAppearanceUpNotification, object: nil)
    }

    /// Updates the app's appearance style value.
    internal static func recalculateStyleIfNeeded() {
        let actualStyle = DarkModeDecision.calculate(DarkModeUserChoice, shared.systemStyle)

        if shared.hidden_style != actualStyle { shared.hidden_style = actualStyle }
    }

    /// Changes the app's UserInterfaceStyle.
    ///
    /// It's matter to change the look of system user controls.
    @available(iOS 13.0, macOS 10.14, *)
    internal static func overrideUserInterfaceStyleIfNeeded() {
        if hidden_changeManually == false { return }
#if os(iOS) && compiler(>=5)
        guard let keyWindow = UIWindow.key else { return }
        var overrideStyle: UIUserInterfaceStyle = .unspecified

        switch DarkModeUserChoice {
        case .auto:
            overrideStyle = .unspecified

        case .on:
            overrideStyle = .dark

        case .off:
            overrideStyle = .light
        }

        keyWindow.overrideUserInterfaceStyle = overrideStyle

#elseif os(macOS)
        switch DarkModeUserChoice {
        case .auto:
            NSApplication.shared.appearance = nil
        case .on:
            NSApplication.shared.appearance = NSAppearance(named: AppearanceService.defaultDarkAppearanceOS)
        case .off:
            NSApplication.shared.appearance = NSAppearance(named: AppearanceService.defaultLightAppearanceOS)
        }
#endif
    }
}

// Local helpers

extension UserDefaults {
    public func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }
}

#if os(iOS)
extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
#endif

// MARK: - Protocols used for unit testing

public protocol NotificationCenterProtocol {
    func addObserver(_ observer: Any,
                     selector aSelector: Selector,
                     name aName: NSNotification.Name?,
                     object anObject: Any?)
    func post(name aName: NSNotification.Name, object anObject: Any?)
}

public protocol UserDefaultsProtocol {
    func valueExists(forKey key: String) -> Bool
    func integer(forKey defaultName: String) -> Int
    func setValue(_ value: Any?, forKey key: String)
}

extension UserDefaults: UserDefaultsProtocol { }
extension NotificationCenter: NotificationCenterProtocol { }
