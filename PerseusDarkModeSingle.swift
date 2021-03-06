//
//  PerseusDarkModeSingle.swift
//  Version: 1.0.4
//
//  Created by Mikhail Zhigulin in 2022.
//
//  Copyright (c) 2022 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//
//
//  MIT License
//
//  Copyright (c) 2022 Mikhail Zhigulin of Novosibirsk
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

// MARK: - Constants

public extension Notification.Name {
    static let makeAppearanceUpNotification = Notification.Name("makeAppearanceUpNotification")
}

public let DARK_MODE_USER_CHOICE_OPTION_KEY = "DarkModeUserChoiceOptionKey"
public let DARK_MODE_USER_CHOICE_DEFAULT = DarkModeOption.auto
public let DARK_MODE_STYLE_DEFAULT = AppearanceStyle.light
public let OBSERVERED_VARIABLE_NAME = "StyleObservable"

// MARK: - Appearance service

public extension UIResponder { var DarkMode: DarkModeProtocol { AppearanceService.shared } }

public class AppearanceService {
    public static var shared: DarkMode = { DarkMode() }()
    private init() { }

    public static var isEnabled: Bool { _isEnabled }

#if DEBUG // Isolated for unit testing
    public static var nCenter: NotificationCenterProtocol = NotificationCenter.default
    public static var ud: UserDefaultsProtocol = UserDefaults.standard
#else
    public static var nCenter = NotificationCenter.default
    public static var ud = UserDefaults.standard
#endif

    public static var DarkModeUserChoice: DarkModeOption {
        get {
            // Load enum Int value

            let rawValue = ud.valueExists(forKey: DARK_MODE_USER_CHOICE_OPTION_KEY) ?
                ud.integer(forKey: DARK_MODE_USER_CHOICE_OPTION_KEY) :
                DARK_MODE_USER_CHOICE_DEFAULT.rawValue

            // Try to cast Int value to enum

            if let result = DarkModeOption.init(rawValue: rawValue) { return result }

            return DARK_MODE_USER_CHOICE_DEFAULT
        }
        set {
            ud.setValue(newValue.rawValue, forKey: DARK_MODE_USER_CHOICE_OPTION_KEY)

            // Used for KVO to immediately notify a change has happened
            recalculateStyleIfNeeded()
        }
    }

    // MARK: - Public API: register stakeholder

    public static func register(stakeholder: Any, selector: Selector) {
        nCenter.addObserver(stakeholder,
                            selector: selector,
                            name: .makeAppearanceUpNotification,
                            object: nil)
    }

    // MARK: - Public API: make the app's appearance up

    public static func makeUp() {
        _isEnabled = true
        _changeManually = true

        if #available(iOS 13.0, *) { overrideUserInterfaceStyleIfNeeded() }

        recalculateStyleIfNeeded()

        nCenter.post(name: .makeAppearanceUpNotification, object: nil)
        _changeManually = false
    }

    @available(iOS 13.0, *)
    public static func processTraitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if _changeManually { return }

        guard let previousSystemStyle = previousTraitCollection?.userInterfaceStyle,
              previousSystemStyle.rawValue != shared.SystemStyle.rawValue
        else { return }

        _systemCalledMakeUp()
    }

    // MARK: - Implementation helpers, privates and internals

    private(set) static var _isEnabled: Bool = false { willSet { if newValue == false { return }}}

    internal static var _changeManually: Bool = false

    internal static func _systemCalledMakeUp() {
        if _changeManually { return }

        _isEnabled = true

        recalculateStyleIfNeeded()
        nCenter.post(name: .makeAppearanceUpNotification, object: nil)
    }

    internal static func recalculateStyleIfNeeded() {
        let actualStyle = DarkModeDecision.calculate(DarkModeUserChoice, shared.SystemStyle)

        if shared._style != actualStyle { shared._style = actualStyle }
    }

    @available(iOS 13.0, *)
    internal static func overrideUserInterfaceStyleIfNeeded() {
        if _changeManually == false { return }

        if let keyWindow = UIApplication.shared.keyWindow {
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
        }
    }
}

// MARK: - Dark Mode

public class DarkMode: NSObject {
    // MARK: - The App's current Appearance Style

    public var Style: AppearanceStyle { _style }

    // MARK: - Observable Appearance Style Value (Using Key-Value Observing)

    @objc public dynamic var StyleObservable: Int = DARK_MODE_STYLE_DEFAULT.rawValue

    // MARK: - System's Appearance Style

    public var SystemStyle: SystemStyle {
        if #available(iOS 13.0, *) {
            guard let keyWindow = UIApplication.shared.keyWindow else { return .unspecified }

            switch keyWindow.traitCollection.userInterfaceStyle {
            case .unspecified:
                return .unspecified
            case .light:
                return .light
            case .dark:
                return .dark

            @unknown default:
                return .unspecified
            }
        } else {
            return .unspecified
        }
    }

    internal var _style: AppearanceStyle = DARK_MODE_STYLE_DEFAULT {
        didSet { StyleObservable = Style.rawValue }
    }
}

// MARK: - Dark Mode decision-making table

public class DarkModeDecision {
    private init() { }

    // MARK: - Calculating Dark Mode decision

    /// Calculates the current appearance style of the app.
    ///
    /// Dark Mode decision-making:
    ///
    ///                    DarkModeOption
    ///     SystemStyle  | auto    | on   | off
    ///     -------------+---------+------+------
    ///     .unspecified | default | dark | light
    ///     .light       | light   | dark | light
    ///     .dark        | dark    | dark | light
    ///
    public class func calculate(_ userChoice: DarkModeOption,
                                _ systemStyle: SystemStyle) -> AppearanceStyle {
        // Calculate outputs

        if (systemStyle == .unspecified) && (userChoice == .auto) {
            return DARK_MODE_STYLE_DEFAULT
        }
        if (systemStyle == .unspecified) && (userChoice == .on) { return .dark }
        if (systemStyle == .unspecified) && (userChoice == .off) { return .light }

        if (systemStyle == .light) && (userChoice == .auto) { return .light }
        if (systemStyle == .light) && (userChoice == .on) { return .dark }
        if (systemStyle == .light) && (userChoice == .off) { return .light }

        if (systemStyle == .dark) && (userChoice == .auto) { return .dark }
        if (systemStyle == .dark) && (userChoice == .on) { return .dark }
        if (systemStyle == .dark) && (userChoice == .off) { return .light }

        // Output default value if somethings goes out of the decision table

        return DARK_MODE_STYLE_DEFAULT
    }
}

// MARK: - Appearance Style Observering

public class DarkModeObserver: NSObject {
    public var action: ((_ newStyle: AppearanceStyle) -> Void)?
    private(set) var objectToObserve = AppearanceService.shared

    public override init() {
        super.init()

        objectToObserve.addObserver(self,
                                    forKeyPath: OBSERVERED_VARIABLE_NAME,
                                    options: .new,
                                    context: nil)
    }

    public init(_ action: @escaping ((_ newStyle: AppearanceStyle) -> Void)) {
        super.init()

        self.action = action
        objectToObserve.addObserver(self,
                                    forKeyPath: OBSERVERED_VARIABLE_NAME,
                                    options: .new,
                                    context: nil)
    }

    public override func observeValue(forKeyPath keyPath: String?,
                                      of object: Any?,
                                      change: [NSKeyValueChangeKey: Any]?,
                                      context: UnsafeMutableRawPointer?) {
        guard
            keyPath == OBSERVERED_VARIABLE_NAME,
            let style = change?[.newKey],
            let styleRawValue = style as? Int,
            let newStyle = AppearanceStyle.init(rawValue: styleRawValue)
        else { return }

        action?(newStyle)
    }

    deinit {
        objectToObserve.removeObserver(self, forKeyPath: OBSERVERED_VARIABLE_NAME)
    }
}

// MARK: - Dark Mode Option

public enum DarkModeOption: Int, CustomStringConvertible {

    case auto = 0
    case on   = 1
    case off  = 2

    public var description: String {
        switch self {
        case .auto:
            return ".auto"
        case .on:
            return ".on"
        case .off:
            return ".off"
        }
    }
}

// MARK: - Appearance Style

public enum AppearanceStyle: Int, CustomStringConvertible {

    case light = 0
    case dark  = 1

    public var description: String {
        switch self {
        case .light:
            return ".light"
        case .dark:
            return ".dark"
        }
    }
}

// MARK: - System Style

public enum SystemStyle: Int, CustomStringConvertible {

    case unspecified = 0
    case light       = 1
    case dark        = 2

    public var description: String {
        switch self {
        case .unspecified:
            return ".unspecified"
        case .light:
            return ".light"
        case .dark:
            return ".dark"
        }
    }
}

// MARK: - Helpers

extension UserDefaults {
    public func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }
}

// MARK: - Used only for unit testing purpose

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

public protocol DarkModeProtocol {
    var Style: AppearanceStyle { get }
    var SystemStyle: SystemStyle { get }

    dynamic var StyleObservable: Int { get }
}

extension UserDefaults: UserDefaultsProtocol { }
extension NotificationCenter: NotificationCenterProtocol { }
extension DarkMode: DarkModeProtocol { }
