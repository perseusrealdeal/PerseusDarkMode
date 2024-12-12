//
//  PerseusDarkModeStar.swift
//  Version: 2.0.0
//
//  PLATFORMS: macOS 10.13+ | iOS 11.0+
//
//  SWIFT: 5.7+ / Xcode 14.2+
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7533 Mikhail Zhigulin of Novosibirsk.
//  Copyright © 7533 PerseusRealDeal
//
//  All rights reserved.
//
//
//  MIT License
//
//  Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 PerseusRealDeal
//
//  The year starts from the creation of the world according to a Slavic calendar.
//  September, the 1st of Slavic year.
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
// swiftlint:disable file_length
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

// MARK: - Notifications

public extension Notification.Name {
    static let MakeAppearanceUpNotification =
        Notification.Name("MakeAppearanceUpNotification")
#if os(macOS)
    static let AppleInterfaceThemeChangedNotification =
        Notification.Name("AppleInterfaceThemeChangedNotification")
#endif
}

// MARK: - Constants

public let DARK_MODE_USER_CHOICE_KEY = "DarkModeUserChoiceOptionKey"
public let DARK_MODE_USER_CHOICE_DEFAULT = DarkModeOption.auto
public let DARK_MODE_STYLE_DEFAULT = AppearanceStyle.light
public let OBSERVERED_VARIABLE_NAME = "styleObservable"
public let DARK_MODE_SETTINGS_KEY = "dark_mode_preference"

// MARK: - DARK MODE Appearance changing functions

public func changeDarkModeManually(_ userChoice: DarkModeOption) {
    // Change Dark Mode value in settings bundle
    UserDefaults.standard.setValue(userChoice.rawValue, forKey: DARK_MODE_SETTINGS_KEY)

    // Change Dark Mode value in Perseus Dark Mode library
    AppearanceService.DarkModeUserChoice = userChoice

    // Update appearance in accoring with changed Dark Mode Style
    AppearanceService.makeUp()
}

public func isDarkModeSettingsChanged() -> DarkModeOption? {
    // Load enum int value from settings
    let option = UserDefaults.standard.valueExists(forKey: DARK_MODE_SETTINGS_KEY) ?
        UserDefaults.standard.integer(forKey: DARK_MODE_SETTINGS_KEY) : -1

    // Try to cast int value to enum
    guard option != -1, let settingsDarkMode = DarkModeOption.init(rawValue: option)
        else { return nil } // Should throw exception if init gives nil

    // Report change
    return settingsDarkMode != AppearanceService.DarkModeUserChoice ? settingsDarkMode : nil
}

// MARK: - Appearance service

// swiftlint:disable identifier_name
public extension Responder {
    var DarkMode: DarkMode { return AppearanceService.shared }
}
// swiftlint:enable identifier_name

public class AppearanceService {

    public static var shared: DarkMode = { _ = it; return DarkMode() }()

    private(set) static var it = { AppearanceService() }()
    private init() {
#if os(macOS)
        DarkModeAgent.distributedNCenter.addObserver(
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
            DarkModeAgent.processAppearanceOSDidChange()
        }
    }

    @available(macOS 10.14, *)
    public static var defaultDarkAppearanceOS: NSAppearance.Name = .darkAqua
    public static var defaultLightAppearanceOS: NSAppearance.Name = .aqua
#endif

    public static var isEnabled: Bool { return hidden_isEnabled }

#if os(macOS)
    /// Default Distributed NotificationCenter.
    public static var distributedNCenter = DistributedNotificationCenter.default
#endif

    /// Default NotificationCenter.
    public static var nCenter = NotificationCenter.default
    /// Default UserDefaults.
    public static var ud = UserDefaults.standard

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

    public static func register(stakeholder: Any, selector: Selector) {
        nCenter.addObserver(stakeholder,
                            selector: selector,
                            name: .MakeAppearanceUpNotification,
                            object: nil)
    }

    // MARK: - Public API: make the app's appearance up

    public static func makeUp() {
        hidden_isEnabled = true
        hidden_changeManually = true

        if #available(iOS 13.0, macOS 10.14, *) { overrideUserInterfaceStyleIfNeeded() }

        recalculateStyleIfNeeded()

        nCenter.post(name: .MakeAppearanceUpNotification, object: nil)
        hidden_changeManually = false
    }

#if os(iOS)
    @available(iOS 13.0, *)
    public static func processTraitCollectionDidChange(
        _ previousTraitCollection: UITraitCollection?) {
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

    private(set) static var hidden_isEnabled: Bool = false {
        willSet { if newValue == false { return }}
    }

    internal static var hidden_changeManually: Bool = false

    internal static func hidden_systemCalledMakeUp() {
        if hidden_changeManually { return }

        hidden_isEnabled = true

        recalculateStyleIfNeeded()
        nCenter.post(name: .MakeAppearanceUpNotification, object: nil)
    }

    public static func recalculateStyleIfNeeded() {
        let actualStyle = DarkModeDecision.calculate(DarkModeUserChoice, shared.systemStyle)

        if shared.hidden_style != actualStyle { shared.hidden_style = actualStyle }
    }

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
            NSApplication.shared.appearance =
                NSAppearance(named: DarkModeAgent.defaultDarkAppearanceOS)
        case .off:
            NSApplication.shared.appearance =
                NSAppearance(named: DarkModeAgent.defaultLightAppearanceOS)
        }
#endif
    }
}

// MARK: - Dark Mode

public class DarkMode: NSObject {

    // MARK: - The App's current Appearance Style

    public var style: AppearanceStyle { return hidden_style }

    // MARK: - Observable Appearance Style Value (Using Key-Value Observing)

    @objc public dynamic var styleObservable: Int = DARK_MODE_STYLE_DEFAULT.rawValue

    // MARK: - System's Appearance Style

    public var systemStyle: SystemStyle {
        if #available(iOS 13.0, macOS 10.14, *) {
#if os(iOS)
            guard let keyWindow = UIWindow.key else { return .unspecified }

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
#elseif os(macOS)
            if let isDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle"),
                isDark == "Dark" {
                return .dark
            } else {
                return .light
            }
#endif
        } else {
            return .unspecified
        }
    }

    internal var hidden_style: AppearanceStyle = DARK_MODE_STYLE_DEFAULT {
        didSet { styleObservable = style.rawValue }
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
    ///                  | DarkModeOption
    ///     -------------+-----------------------
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

    // swiftlint:disable:this block_based_kvo
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

// MARK: - UISystemKit

#if os(iOS)
public typealias Color = UIColor
#elseif os(macOS)
public typealias Color = NSColor
#endif

/// Creates the instance of UIColor using RGBA color model.
///
/// ```swift
/// let _ = rgba255(235, 235, 245, 0.6)
/// ```
/// or
///
/// ```swift
/// let _ = rgba255(255, 255, 255)
/// ```
///
/// - Parameters:
///   - red: From 0 to 255.
///   - green: From 0 to 255.
///   - blue: From 0 to 255.
///   - alpha: From 0 to 1.0.
/// - Returns: The instance of UIColor type.
public func rgba255(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0)
    -> Color { return Color(red: red/255, green: green/255, blue: blue/255, alpha: alpha) }

/// Used to exctruct RGBA of the UIColor instance
public extension Color {
    /// Returns red, green, and blue from 0 to 255, and alpha from 0.0 to 1.0.
    ///
    /// ```swift
    /// let rgba = UIColor.red.RGBA255
    /// ```
    var RGBA255: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red*255, green*255, blue*255, alpha)
    }
}

#if os(iOS)

@IBDesignable
public class DarkModeImageView: UIImageView {

    @IBInspectable
    public var imageLight: UIImage? {
        didSet {
            light = imageLight
            image = DarkMode.style == .light ? light : dark
        }
    }

    @IBInspectable
    public var imageDark: UIImage? {
        didSet {
            dark = imageDark
            image = DarkMode.style == .light ? light : dark
        }
    }

    private(set) var darkModeObserver: DarkModeObserver?

    private(set) var light: UIImage?
    private(set) var dark: UIImage?

    override init(frame: CGRect) {
        super.init(frame: frame)

        log.message("[\(type(of: self))].\(#function)")

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        log.message("[\(type(of: self))].\(#function)")

        configure()
    }

    private func configure() {
        darkModeObserver = DarkModeObserver { style in
            self.image = style == .light ? self.light : self.dark
        }

        image = DarkMode.style == .light ? self.light : self.dark
    }

    public func configure(_ light: UIImage?, _ dark: UIImage?) {
        self.light = light
        self.dark = dark

        darkModeObserver?.action = { style in
            self.image = style == .light ? self.light : self.dark
        }

        image = DarkMode.style == .light ? self.light : self.dark
    }
}

#elseif os(macOS)

public enum ScaleImageViewMacOS: Int, CustomStringConvertible {

    case scaleNone                  = 0 // No scale at all
    case axesIndependently          = 1 // Aspect Fill
    case proportionallyUpOrDown     = 2 // Aspect Fit
    case proportionallyDown         = 3 // Center Top
    case proportionallyClipToBounds = 4 // Aspect Fill with cliping to ImageView bounds

    public var description: String {
        switch self {
        case .scaleNone:
            return "As is, no scaling."
        case .axesIndependently:
            return "Aspect Fill."
        case .proportionallyUpOrDown:
            return "Aspect Fit."
        case .proportionallyDown:
            return "Center Top."
        case .proportionallyClipToBounds:
            return "Aspect Fill cliped to bounds."
        }
    }

    public var value: NSImageScaling {
        switch self {
        case .scaleNone:
            return .scaleNone
        case .axesIndependently:
            return .scaleAxesIndependently
        case .proportionallyUpOrDown:
            return .scaleProportionallyUpOrDown
        case .proportionallyDown:
            return .scaleProportionallyDown
        case .proportionallyClipToBounds:
            return .scaleNone
        }
    }
}

@IBDesignable
public class DarkModeImageView: NSImageView {

    @IBInspectable
    public var imageLight: NSImage? {
        didSet {
            image = DarkMode.style == .light ? imageLight : imageDark
        }
    }

    @IBInspectable
    public var imageDark: NSImage? {
        didSet {
            image = DarkMode.style == .light ? imageLight : imageDark
        }
    }

    @IBInspectable
    public var aspectFillClipToBounds: Bool = false

    public var customScale: ScaleImageViewMacOS = .scaleNone {
        didSet {
            guard customScale != .proportionallyClipToBounds else {

                self.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                self.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

                self.aspectFillClipToBounds = true
                self.imageScaling = .scaleNone

                return
            }

            self.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
            self.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

            self.aspectFillClipToBounds = false
            self.imageScaling = customScale.value
        }
    }

    private(set) var darkModeObserver: DarkModeObserver?

    override public func awakeFromNib() {

        log.message("[\(type(of: self))].\(#function)")

        guard aspectFillClipToBounds else { return }

        self.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        self.imageScaling = .scaleNone
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        log.message("[\(type(of: self))].\(#function)")

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        log.message("[\(type(of: self))].\(#function)")

        configure()
    }

    public func configure(_ light: NSImage?, _ dark: NSImage?) {
        configure()

        self.imageLight = light
        self.imageDark = dark
    }

    private func configure() {
        darkModeObserver = DarkModeObserver { style in
            self.image = style == .light ? self.imageLight : self.imageDark
        }
    }

    override public func draw(_ dirtyRect: NSRect) {
        guard aspectFillClipToBounds, let image = self.image else {
            super.draw(dirtyRect)
            return
        }

        // Get variables

        let viewWidth = self.bounds.size.width
        let viewHeight = self.bounds.size.height

        let width = image.size.width
        let height = image.size.height

        // https://study.com/learn/lesson/what-is-aspect-ratio.html
        let imageViewRatio = viewWidth / viewHeight
        let imageRatio = width / height

        // Scale image of the ImageView with clipping to bounds

        image.size.width = imageRatio < imageViewRatio ? viewWidth : viewHeight * imageRatio
        image.size.height = imageRatio < imageViewRatio ? viewWidth / imageRatio : viewHeight

        super.draw(dirtyRect)
    }
}

#endif

public protocol SemanticColorProtocol {

// MARK: - FOREGROUND CONTENT

    // MARK: - Label Colors

    /// Label.
    ///
    /// - Light: 0, 0, 0
    /// - Dark: 255, 255, 255
    static var labelPerseus: Color { get }

    /// Secondary label.
    ///
    /// - Light: 60, 60, 67, 0.6
    /// - Dark: 235, 235, 245, 0.6
    static var secondaryLabelPerseus: Color { get }

    /// Tertiary label.
    ///
    /// - Light: 60, 60, 67, 0.3
    /// - Dark: 235, 235, 245, 0.3
    static var tertiaryLabelPerseus: Color { get }

    /// Quaternary label.
    ///
    /// - Light: 60, 60, 67, 0.18
    /// - Dark: 235, 235, 245, 0.16
    static var quaternaryLabelPerseus: Color { get }

    // MARK: - Text Colors

    /// Placeholder text.
    ///
    /// - Light: 60, 60, 67, 0.3
    /// - Dark: 235, 235, 245, 0.3
    static var placeholderTextPerseus: Color { get }

    // MARK: - Separator Colors

    /// Separator.
    ///
    /// - Light: 60, 60, 67, 0.29
    /// - Dark: 84, 84, 88, 0.6
    static var separatorPerseus: Color { get }

    /// Opaque separator.
    ///
    /// - Light: 198, 198, 200
    /// - Dark: 56, 56, 58
    static var opaqueSeparatorPerseus: Color { get }

    // MARK: - Link Color

    /// Link.
    ///
    /// - Light: 0, 122, 255
    /// - Dark: 9, 132, 255
    static var linkPerseus: Color { get }

    // MARK: - Fill Colors

    /// System fill.
    ///
    /// - Light: 120, 120, 128, 0.2
    /// - Dark: 120, 120, 128, 0.36
    static var systemFillPerseus: Color { get }

    /// Secondary system fill.
    ///
    /// - Light: 120, 120, 128, 0.16
    /// - Dark: 120, 120, 128, 0.32
    static var secondarySystemFillPerseus: Color { get }

    /// Tertiary system fill.
    ///
    /// - Light: 118, 118, 128, 0.12
    /// - Dark: 118, 118, 128, 0.24
    static var tertiarySystemFillPerseus: Color { get }

    /// Quaternary system fill.
    ///
    /// - Light: 116, 116, 128, 0.08
    /// - Dark: 118, 118, 128, 0.18
    static var quaternarySystemFillPerseus: Color { get }

// MARK: - BACKGROUND CONTENT

    // MARK: - Standard

    /// System background.
    ///
    /// - Light: 255, 255, 255
    /// - Dark: 28, 28, 30
    static var systemBackgroundPerseus: Color { get }

    /// Secondary system background.
    ///
    /// - Light: 242, 242, 247
    /// - Dark: 44, 44, 46
    static var secondarySystemBackgroundPerseus: Color { get }

    /// Tertiary system background.
    ///
    /// - Light: 255, 255, 255
    /// - Dark: 58, 58, 60
    static var tertiarySystemBackgroundPerseus: Color { get }

    // MARK: - Grouped

    /// System grouped background.
    ///
    /// - Light: 242, 242, 247
    /// - Dark: 28, 28, 30
    static var systemGroupedBackgroundPerseus: Color { get }

    /// Secondary system grouped background.
    ///
    /// - Light: 255, 255, 255
    /// - Dark: 44, 44, 46
    static var secondarySystemGroupedBackgroundPerseus: Color { get }

    /// Tertiary system grouped background.
    ///
    /// - Light: 242, 242, 247
    /// - Dark: 58, 58, 60
    static var tertiarySystemGroupedBackgroundPerseus: Color { get }
}

public protocol SystemColorProtocol {

    /// Red is .systemRed
    ///
    /// - Light: 255, 59, 48
    /// - Dark: 255, 69, 58
    static var perseusRed: Color { get }

    /// Orange is .systemOrange
    ///
    /// - Light: 255, 149, 0
    /// - Dark: 255, 159, 10
    static var perseusOrange: Color { get }

    /// Yellow is .systemYellow
    ///
    /// - Light: 255, 204, 0
    /// - Dark: 255, 214, 10
    static var perseusYellow: Color { get }

    /// Green is .systemGreenGreen
    ///
    /// - Light: 52, 199, 89
    /// - Dark: 48, 209, 88
    static var perseusGreen: Color { get }

    /// Mint is .systemMint
    ///
    /// - Light: 0, 199, 190
    /// - Dark: 102, 212, 207
    static var perseusMint: Color { get }

    /// Teal is .systemTeal
    ///
    /// - Light: 48, 176, 199
    /// - Dark: 64, 200, 224
    static var perseusTeal: Color { get }

    /// Cyan is .systemCyan
    ///
    /// - Light: 50, 173, 230
    /// - Dark: 100, 210, 255
    static var perseusCyan: Color { get }

    /// Blue is .systemBlue
    ///
    /// - Light: 0, 122, 255
    /// - Dark: 10, 132, 255
    static var perseusBlue: Color { get }

    /// Indigo is .systemIndigo
    ///
    /// - Light: 88, 86, 214
    /// - Dark: 94, 92, 230
    static var perseusIndigo: Color { get }

    /// Purple is .systemPurple
    ///
    /// - Light: 175, 82, 222
    /// - Dark: 191, 90, 242
    static var perseusPurple: Color { get }

    /// Pink is .systemPink
    ///
    /// - Light: 255, 45, 85
    /// - Dark: 255, 55, 95
    static var perseusPink: Color { get }

    /// Brown is .systemBrown
    ///
    /// - Light: 162, 132, 94
    /// - Dark: 172, 142, 104
    static var perseusBrown: Color { get }

// MARK: - System Gray Colors

    /// Gray is .systemGray
    ///
    /// - Light: 142, 142, 147
    /// - Dark: 142, 142, 147
    static var perseusGray: Color { get }

    /// Gray (2) is .systemGray62
    ///
    /// - Light: 174, 174, 178
    /// - Dark: 99, 99, 102
    static var perseusGray2: Color { get }

    /// Gray (3) is .systemGray3
    ///
    /// - Light: 199, 199, 204
    /// - Dark: 72, 72, 74
    static var perseusGray3: Color { get }

    /// Gray (4) is .systemGray4
    ///
    /// - Light: 209, 209, 214
    /// - Dark: 58, 58, 60
    static var perseusGray4: Color { get }

    /// Gray (5) is .systemGray5
    ///
    /// - Light: 229, 229, 234
    /// - Dark: 44, 44, 46
    static var perseusGray5: Color { get }

    /// Gray (6) is .systemGray6
    ///
    /// - Light: 242, 242, 247
    /// - Dark: 28, 28, 30
    static var perseusGray6: Color { get }
}

extension Color: SemanticColorProtocol {

    /// .label
    public static var labelPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(0, 0, 0) : rgba255(255, 255, 255)
    }

    /// .secondaryLabel
    public static var secondaryLabelPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(60, 60, 67, 0.6) : rgba255(235, 235, 245, 0.6)
    }

    /// .tertiaryLabel
    public static var tertiaryLabelPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(60, 60, 67, 0.3) : rgba255(235, 235, 245, 0.3)
    }

    /// .quaternaryLabel
    public static var quaternaryLabelPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(60, 60, 67, 0.18) : rgba255(235, 235, 245, 0.16)
    }

    /// .placeholderText
    public static var placeholderTextPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(60, 60, 67, 0.3) : rgba255(235, 235, 245, 0.3)
    }

    /// .separator
    public static var separatorPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(60, 60, 67, 0.29) : rgba255(84, 84, 88, 0.6)
    }

    /// .opaqueSeparator
    public static var opaqueSeparatorPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(198, 198, 200) : rgba255(56, 56, 58)
    }

    /// .link
    public static var linkPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(0, 122, 255) : rgba255(9, 132, 255)
    }

    /// .systemFill
    public static var systemFillPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(120, 120, 128, 0.2) : rgba255(120, 120, 128, 0.36)
    }

    /// .secondarySystemFill
    public static var secondarySystemFillPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(120, 120, 128, 0.16) : rgba255(120, 120, 128, 0.32)
    }

    /// .tertiarySystemFill
    public static var tertiarySystemFillPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(118, 118, 128, 0.12) : rgba255(118, 118, 128, 0.24)
    }

    /// .quaternarySystemFill
    public static var quaternarySystemFillPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(116, 116, 128, 0.08) : rgba255(118, 118, 128, 0.18)
    }

    /// .systemBackground
    public static var systemBackgroundPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(255, 255, 255) : rgba255(28, 28, 30)
    }

    /// .secondarySystemBackground
    public static var secondarySystemBackgroundPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(242, 242, 247) : rgba255(44, 44, 46)
    }

    /// .tertiarySystemBackground
    public static var tertiarySystemBackgroundPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(255, 255, 255) : rgba255(58, 58, 60)
    }

    /// .systemGroupedBackground
    public static var systemGroupedBackgroundPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(242, 242, 247) : rgba255(28, 28, 30)
    }

    /// .secondarySystemGroupedBackground
    public static var secondarySystemGroupedBackgroundPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(255, 255, 255) : rgba255(44, 44, 46)
    }

    /// .tertiarySystemGroupedBackground
    public static var tertiarySystemGroupedBackgroundPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(242, 242, 247) : rgba255(58, 58, 60)
    }
}

extension Color: SystemColorProtocol {

    /// .systemRed
    public static var perseusRed: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(255, 59, 48) : rgba255(255, 69, 58)
    }

    /// .systemOrange
    public static var perseusOrange: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(255, 149, 0) : rgba255(255, 159, 10)
    }

    /// .systemYellow
    public static var perseusYellow: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(255, 204, 0) : rgba255(255, 214, 10)
    }

    /// .systemGreen
    public static var perseusGreen: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(52, 199, 89) : rgba255(48, 209, 88)
    }

    /// .systemMint
    public static var perseusMint: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(0, 199, 190) : rgba255(102, 212, 207)
    }

    /// .systemTeal
    public static var perseusTeal: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(48, 176, 199) : rgba255(64, 200, 224)
    }

    /// .systemCyan
    public static var perseusCyan: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(50, 173, 230) : rgba255(100, 210, 255)
    }

    /// .systemBlue
    public static var perseusBlue: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(0, 122, 255) : rgba255(10, 132, 255)
    }

    /// .systemIndigo
    public static var perseusIndigo: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(88, 86, 214) : rgba255(94, 92, 230)
    }

    /// .systemPurple
    public static var perseusPurple: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(175, 82, 222) : rgba255(191, 90, 242)
    }

    /// .systemPink
    public static var perseusPink: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(255, 45, 85) : rgba255(255, 55, 95)
    }

    /// .systemBrown
    public static var perseusBrown: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(162, 132, 94) : rgba255(172, 142, 104)
    }

    /// .systemGray
    public static var perseusGray: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(142, 142, 147) : rgba255(142, 142, 147)
    }

    /// .systemGray2
    public static var perseusGray2: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(174, 174, 178) : rgba255(99, 99, 102)
    }

    /// .systemGray3
    public static var perseusGray3: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(199, 199, 204) : rgba255(72, 72, 74)
    }

    /// .systemGray4
    public static var perseusGray4: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(209, 209, 214) : rgba255(58, 58, 60)
    }

    /// .systemGray5
    public static var perseusGray5: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(229, 229, 234) : rgba255(44, 44, 46)
    }

    /// .systemGray6
    public static var perseusGray6: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(242, 242, 247) : rgba255(28, 28, 30)
    }
}
