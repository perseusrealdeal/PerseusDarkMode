//
//  PerseusDarkModeSingle.swift
//  
//
//  Created by Mikhail Zhigulin on 30.04.2022.
//
//  Copyright (c) 2022 Mikhail Zhigulin. All rights reserved.
//
//
//  MIT License
//
//  Copyright (c) 2022 Mikhail Zhigulin
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

public extension Notification.Name
{
    static let makeAppearanceUpStatement = Notification.Name("makeAppearanceUpStatement")
}

public let DARK_MODE_USER_CHOICE_OPTION_KEY = "DarkModeUserChoiceOptionKey"
public let DARK_MODE_USER_CHOICE_DEFAULT = DarkModeOption.auto
public let DARK_MODE_STYLE_DEFAULT = AppearanceStyle.light

// MARK: - Appearance service

public class AppearanceService
{
    // MARK: - Properties
    
    public static var isEnabled        : Bool { _isEnabled }
    
    /// Used to make possible applying Black White approach
    private(set) static var _isEnabled : Bool = false { willSet { if newValue == false { return }}}
    /// Used to reduce double calling of traitCollectionDidChange
    internal static var _changeManually: Bool = false
    
    #if DEBUG // Isolated for unit testing
    public static var nCenter: NotificationCenterProtocol = NotificationCenter.default
    public static var ud     : UserDefaultsProtocol = UserDefaults.standard
    #else
    public static var nCenter = NotificationCenter.default
    public static var ud = UserDefaults.standard
    #endif
    
    // MARK: - Singleton
    
    public static var shared: DarkMode = { DarkMode() } ()
    private init() { }
    
    // MARK: - Public API: register subscriber
    
    public static func register(observer: Any, selector: Selector)
    {
        nCenter.addObserver(observer,
                            selector: selector,
                            name    : .makeAppearanceUpStatement,
                            object  : nil)
    }
    
    // MARK: - Public API: call each subscriber to adapt appearance
    
    public static func makeUp()
    {
        _isEnabled = true
        _changeManually = true
        
        if #available(iOS 13.0, *) { overrideUserInterfaceStyleIfNeeded() }
        
        recalculateStyleIfNeeded()
        
        nCenter.post(name: .makeAppearanceUpStatement, object: nil)
        _changeManually = false
    }
    
    internal static func _systemCalledMakeUp()
    {
        //print(#function)
        if _changeManually { return }
        
        _isEnabled = true
        
        recalculateStyleIfNeeded()
        nCenter.post(name: .makeAppearanceUpStatement, object: nil)
    }
    
    // MARK: - Dark Mode Style saved in UserDafaults
    
    public static var DarkModeUserChoice: DarkModeOption
    {
        get
        {
            // load enum int value
            
            let rawValue = ud.valueExists(forKey: DARK_MODE_USER_CHOICE_OPTION_KEY) ?
                ud.integer(forKey: DARK_MODE_USER_CHOICE_OPTION_KEY) :
                DARK_MODE_USER_CHOICE_DEFAULT.rawValue
            
            // try to cast int value to enum
            
            if let result = DarkModeOption.init(rawValue: rawValue) { return result }
            
            return DARK_MODE_USER_CHOICE_DEFAULT
        }
        set
        {
            ud.setValue(newValue.rawValue, forKey: DARK_MODE_USER_CHOICE_OPTION_KEY)
            
            // Used for KVO to immediately notify that change has happened
            recalculateStyleIfNeeded()
        }
    }
    
    internal static func recalculateStyleIfNeeded()
    {
        let actualStyle = DarkModeDecision.calculate(DarkModeUserChoice, shared.SystemStyle)
        
        if shared._style != actualStyle { shared._style = actualStyle }
    }
    
    @available(iOS 13.0, *)
    internal static func overrideUserInterfaceStyleIfNeeded()
    {
        if _changeManually == false { return }
        
        if let keyWindow = UIApplication.shared.keyWindow
        {
            var overrideStyle: UIUserInterfaceStyle = .unspecified
            
            switch DarkModeUserChoice
            {
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

public class DarkMode: NSObject
{
    // MARK: - App's Dark Mode Style
    
    internal var _style                     : AppearanceStyle = DARK_MODE_STYLE_DEFAULT
    {
        didSet { StyleObservable = Style.rawValue }
    }
    
    /// Actual the app's Dark Mode style value, available only for reading
    public var Style                        : AppearanceStyle { _style }
    
    // MARK: - Observable Dark Mode Value (Using Key-Value Observing)
    
    /// Triggers if Style is changed, use KVO to be notified immediately
    @objc public dynamic var StyleObservable: Int = DARK_MODE_STYLE_DEFAULT.rawValue
    
    // MARK: - System's Dark Mode Style
    
    public var SystemStyle                  : SystemStyle
    {
        if #available(iOS 13.0, *)
        {
            guard let keyWindow = UIApplication.shared.keyWindow else { return .unspecified }
            
            switch keyWindow.traitCollection.userInterfaceStyle
            {
            case .unspecified:
                return .unspecified
            case .light:
                return .light
            case .dark:
                return .dark
                
            @unknown default:
                return .unspecified
            }
        }
        else
        {
            return .unspecified
        }
    }
}

public class DarkModeDecision
{
    // MARK: - Private init
    
    private init() { }
    
    // MARK: - Calculating Dark Mode decision
    
    /// Decision table for Actual Style
    ///
    /// — — — — — — — — — — — — — — DarkModeOption — — — — —
    /// — — — — — — — — — — — — auto — — — on — — — — off  — —
    /// — — — — — — — — — — — — — — — — — — — — — — — — —
    /// System style  .unspecified            default            dark              light
    /// System style  .light                         light               dark              light
    /// System style  .dark                         dark              dark              light
    /// — — — — — — — — — — — — — — — — — — — — — — — — —
    ///
    /// Cases where system style is .unspecified happen only if iOS ealy then 13
    ///
    public class func calculate(_ userChoice : DarkModeOption,
                                _ systemStyle: SystemStyle) -> AppearanceStyle
    {
        // Calculate outputs
        
        if (systemStyle == .unspecified) && (userChoice == .auto)
        {
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

public class DarkModeObserver: NSObject
{
    public var action         : ((_ newStyle: AppearanceStyle)->Void)?
    public let objectToObserve: DarkMode
    
    public init(_ value: DarkMode)
    {
        objectToObserve = value
        super.init()
        
        objectToObserve.addObserver(self,
                                    forKeyPath: "StyleObservable",
                                    options   : .new,
                                    context   : nil)
    }
    
    public override func observeValue(forKeyPath keyPath: String?,
                                      of object         : Any?,
                                      change            : [NSKeyValueChangeKey : Any]?,
                                      context           : UnsafeMutableRawPointer?)
    {
        guard
            keyPath == "StyleObservable",
            let style = change?[.newKey],
            let styleRawValue = style as? Int,
            let newStyle = AppearanceStyle.init(rawValue: styleRawValue)
        else { return }
        
        action?(newStyle)
    }
    
    deinit
    {
        objectToObserve.removeObserver(self, forKeyPath: "StyleObservable")
    }
}

public enum DarkModeOption: Int, CustomStringConvertible
{
    case auto = 0
    case on   = 1
    case off  = 2
    
    public var description: String
    {
        switch self
        {
        case .auto:
            return ".auto"
        case .on:
            return ".on"
        case .off:
            return ".off"
        }
    }
}

public enum AppearanceStyle: Int, CustomStringConvertible
{
    case light = 0
    case dark  = 1
    
    public var description: String
    {
        switch self
        {
        case .light:
            return ".light"
        case .dark:
            return ".dark"
        }
    }
}

public enum SystemStyle: Int, CustomStringConvertible
{
    case unspecified = 0
    case light       = 1
    case dark        = 2
    
    public var description: String
    {
        switch self
        {
        case .unspecified:
            return ".unspecified"
        case .light:
            return ".light"
        case .dark:
            return ".dark"
        }
    }
}

// MARK: - Setting Dark Mode Up by default

public extension UIResponder { var DarkMode: DarkModeProtocol { AppearanceService.shared } }

public class UIWindowAdaptable: UIWindow
{
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)
    {
        if AppearanceService._changeManually { return }
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard #available(iOS 13.0, *),
              let previousSystemStyle = previousTraitCollection?.userInterfaceStyle,
              previousSystemStyle.rawValue != DarkMode.SystemStyle.rawValue
        else { return }
        
        AppearanceService._systemCalledMakeUp()
    }
}

// MARK: - Dark Mode Image View

public class DarkModeImageView: UIImageView
{
    private(set) var darkModeObserver = DarkModeObserver(AppearanceService.shared)
    
    private(set) var imageLight: UIImage?
    private(set) var imageDark : UIImage?
    
    public func setUp(_ light: UIImage?, _ dark: UIImage?)
    {
        imageLight = light
        imageDark = dark
        
        image = AppearanceService.shared.Style == .light ? light : dark
        darkModeObserver.action = { style in  self.image = style == .light ? light : dark }
    }
}

// MARK: Adapted System Colors Requirements

public protocol UISystemColorsAdapted
{
    // MARK: - Default set of system colors
    
    ///
    /// System colors.
    ///
    static var systemRed_Adapted   : UIColor { get }
    static var systemOrange_Adapted: UIColor { get }
    static var systemYellow_Adapted: UIColor { get }
    static var systemGreen_Adapted : UIColor { get }
    static var systemMint_Adapted  : UIColor { get }
    static var systemTeal_Adapted  : UIColor { get }
    static var systemCyan_Adapted  : UIColor { get }
    static var systemBlue_Adapted  : UIColor { get }
    static var systemIndigo_Adapted: UIColor { get }
    static var systemPurple_Adapted: UIColor { get }
    static var systemPink_Adapted  : UIColor { get }
    static var systemBrown_Adapted : UIColor { get }
    
    ///
    /// System gray group.
    ///
    static var systemGray_Adapted  : UIColor { get }
    static var systemGray2_Adapted : UIColor { get }
    static var systemGray3_Adapted : UIColor { get }
    static var systemGray4_Adapted : UIColor { get }
    static var systemGray5_Adapted : UIColor { get }
    static var systemGray6_Adapted : UIColor { get }
}

// MARK: - Adapted System Colors

extension UIColor: UISystemColorsAdapted
{
    ///
    /// SYSTEM RED
    ///
    public static var systemRed_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(255, 59, 48) : rgba255(255, 69, 58)
            
            return color
        }
        
        return .systemRed
    }
    
    ///
    /// SYSTEM ORANGE
    ///
    public static var systemOrange_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(255, 149, 0) : rgba255(255, 159, 10)
            
            return color
        }
        
        return .systemOrange
    }
    
    ///
    /// SYSTEM YELLOW
    ///
    public static var systemYellow_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(255, 204, 0) : rgba255(255, 214, 10)
            
            return color
        }
        
        return .systemYellow
    }
    
    ///
    /// SYSTEM GREEN
    ///
    public static var systemGreen_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(52, 199, 89) : rgba255(48, 209, 88)
            
            return color
        }
        
        return .systemGreen
    }
    
    ///
    /// SYSTEM MINT
    ///
    public static var systemMint_Adapted: UIColor
    {
        //
        // .systemMint is not available in SDK
        //
        let color = AppearanceService.shared.Style == .light ?
            
            rgba255(0, 199, 190) : rgba255(102, 212, 207)
        
        return color
    }
    
    ///
    /// SYSTEM TEAL
    ///
    public static var systemTeal_Adapted: UIColor
    {
        // Gives unexpected color in iOS 13 and higher.
        //
        // Tested on iOS 13.7.
        //
        // Specification RGBA: 48, 176, 199 in Light.
        // Specification RGBA: 64, 200, 224 in Dark.
        //
        // But it doesn't meet SDK .systemTeal certain color value in iOS 13 and higher.
        //
        // LINK to .systemTeal color specification:
        // https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/
        //
        // So, SDK version is used for sure.
        // SDK version has been extracted from iOS 13.7.
        
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(90, 200, 250) : rgba255(100, 210, 255)
            
            return color
        }
        
        return .systemTeal
        
    }
    
    ///
    /// SYSTEM CYAN
    ///
    public static var systemCyan_Adapted: UIColor
    {
        //
        // .systemCyan is not available in SDK
        //
        let color = AppearanceService.shared.Style == .light ?
            
            rgba255(50, 173, 230) : rgba255(100, 210, 255)
        
        return color
    }
    
    ///
    /// SYSTEM BLUE
    ///
    public static var systemBlue_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(0, 122, 255) : rgba255(10, 132, 255)
            
            return color
        }
        
        return .systemBlue
    }
    
    ///
    /// SYSTEM INDIGO
    ///
    public static var systemIndigo_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(88, 86, 214) : rgba255(94, 92, 230)
            
            return color
        }
        
        return .systemIndigo
    }
    
    ///
    /// SYSTEM PURPLE
    ///
    public static var systemPurple_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(175, 82, 222) : rgba255(191, 90, 242)
            
            return color
        }
        
        return .systemPurple
    }
    
    ///
    /// SYSTEM PINK
    ///
    public static var systemPink_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(255, 45, 85) : rgba255(255, 55, 95)
            
            return color
        }
        
        return .systemPink
    }
    
    ///
    /// SYSTEM BROWN
    ///
    public static var systemBrown_Adapted: UIColor
    {
        //
        // .systemBrown is not available in SDK
        //
        let color = AppearanceService.shared.Style == .light ?
            
            rgba255(162, 132, 94) : rgba255(172, 142, 104)
        
        return color
    }
    
    ///
    /// SYSTEM GRAY
    ///
    public static var systemGray_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(142, 142, 147) : rgba255(142, 142, 147)
            
            return color
        }
        
        return .systemGray
    }
    
    ///
    /// SYSTEM GRAY 2
    ///
    public static var systemGray2_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(174, 174, 178) : rgba255(99, 99, 102)
            
            return color
        }
        
        return .systemGray2
    }
    
    ///
    /// SYSTEM GRAY 3
    ///
    public static var systemGray3_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(199, 199, 204) : rgba255(72, 72, 74)
            
            return color
        }
        
        return .systemGray3
    }
    
    ///
    /// SYSTEM GRAY 4
    ///
    public static var systemGray4_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(209, 209, 214) : rgba255(58, 58, 60)
            
            return color
        }
        
        return .systemGray4
    }
    
    ///
    /// SYSTEM GRAY 5
    ///
    public static var systemGray5_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(229, 229, 234) : rgba255(44, 44, 46)
            
            return color
        }
        
        return .systemGray5
    }
    
    ///
    /// SYSTEM GRAY 6
    ///
    public static var systemGray6_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(242, 242, 247) : rgba255(28, 28, 30)
            
            return color
        }
        
        return .systemGray6
    }
}

// MARK: Adapted Semantic Colors Requirements

public protocol UISemanticColorsAdapted
{
    // MARK: - For foreground content
    ///
    /// Label Colors
    ///
    static var label_Adapted               : UIColor { get }
    static var secondaryLabel_Adapted      : UIColor { get }
    static var tertiaryLabel_Adapted       : UIColor { get }
    static var quaternaryLabel_Adapted     : UIColor { get }
    
    ///
    /// Text Colors
    ///
    static var placeholderText_Adapted     : UIColor { get }
    
    ///
    /// Separator Colors
    ///
    static var separator_Adapted           : UIColor { get }
    static var opaqueSeparator_Adapted     : UIColor { get }
    
    ///
    /// Link Color
    ///
    static var link_Adapted                : UIColor { get }
    
    ///
    /// Fill Colors
    ///
    static var systemFill_Adapted          : UIColor { get }
    static var secondarySystemFill_Adapted : UIColor { get }
    static var tertiarySystemFill_Adapted : UIColor { get }
    static var quaternarySystemFill_Adapted: UIColor { get }
    
    // MARK: - For background content
    ///
    /// Standard Content Background Colors
    ///
    static var systemBackground_Adapted                : UIColor { get }
    static var secondarySystemBackground_Adapted       : UIColor { get }
    static var tertiarySystemBackground_Adapted        : UIColor { get }
    
    ///
    /// Grouped Content Background Colors
    ///
    static var systemGroupedBackground_Adapted         : UIColor { get }
    static var secondarySystemGroupedBackground_Adapted: UIColor { get }
    static var tertiarySystemGroupedBackground_Adapted : UIColor { get }
    
}

// MARK: Adapted Semantic Colors

extension UIColor: UISemanticColorsAdapted
{
    // MARK: - Foreground
    
    ///
    /// Label Colors
    ///
    public static var label_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(0, 0, 0) : rgba255(255, 255, 255)
            
            return color
        }
        
        return .label
    }
    
    public static var secondaryLabel_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(60, 60, 67, 0.6) : rgba255(235, 235, 245, 0.6)
            
            return color
        }
        
        return .secondaryLabel
    }
    
    public static var tertiaryLabel_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(60, 60, 67, 0.3) : rgba255(235, 235, 245, 0.3)
            
            return color
        }
        
        return .tertiaryLabel
    }
    
    public static var quaternaryLabel_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(60, 60, 67, 0.18) : rgba255(235, 235, 245, 0.18)
            
            return color
        }
        
        return .quaternaryLabel
    }
    
    ///
    /// Text Colors
    ///
    public static var placeholderText_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(60, 60, 67, 0.3) : rgba255(235, 235, 245, 0.3)
            
            return color
        }
        
        return .placeholderText
    }
    
    ///
    /// Separator Colors
    ///
    public static var separator_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(60, 60, 67, 0.29) : rgba255(84, 84, 88, 0.6)
            
            return color
        }
        
        return .separator
    }
    
    public static var opaqueSeparator_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(198, 198, 200) : rgba255(56, 56, 58)
            
            return color
        }
        
        return .opaqueSeparator
    }
    
    ///
    /// Link Color
    ///
    public static var link_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(0, 122, 255) : rgba255(9, 132, 255)
            
            return color
        }
        
        return .link
    }
    
    ///
    /// Fill Colors
    ///
    public static var systemFill_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(120, 120, 128, 0.2) : rgba255(120, 120, 128, 0.36)
            
            return color
        }
        
        return .systemFill
    }
    
    public static var secondarySystemFill_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(120, 120, 128, 0.16) : rgba255(120, 120, 128, 0.32)
            
            return color
        }
        
        return .secondarySystemFill
    }
    
    public static var tertiarySystemFill_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(118, 118, 128, 0.12) : rgba255(118, 118, 128, 0.24)
            
            return color
        }
        
        return .tertiarySystemFill
    }
    
    public static var quaternarySystemFill_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(116, 116, 128, 0.08) : rgba255(118, 118, 128, 0.18)
            
            return color
        }
        
        return .quaternarySystemFill
    }
    
    // MARK: - Background
    
    ///
    /// Standard Content Background Colors
    ///
    public static var systemBackground_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(255, 255, 255) : rgba255(28, 28, 30)
            
            return color
        }
        
        return .systemBackground
    }
    
    public static var secondarySystemBackground_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(242, 242, 247) : rgba255(44, 44, 46)
            
            return color
        }
        
        return .secondarySystemBackground
    }
    
    public static var tertiarySystemBackground_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(255, 255, 255) : rgba255(58, 58, 60)
            
            return color
        }
        
        return .tertiarySystemBackground
    }
    
    ///
    /// Grouped Content Background Colors
    ///
    public static var systemGroupedBackground_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(242, 242, 247) : rgba255(28, 28, 30)
            
            return color
        }
        
        return .systemGroupedBackground
    }
    
    public static var secondarySystemGroupedBackground_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(255, 255, 255) : rgba255(44, 44, 46)
            
            return color
        }
        
        return .secondarySystemGroupedBackground
    }
    
    public static var tertiarySystemGroupedBackground_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(242, 242, 247) : rgba255(58, 58, 60)
            
            return color
        }
        
        return .tertiarySystemGroupedBackground
    }
}

// MARK: - Protocols used for unit testing

public protocol NotificationCenterProtocol
{
    func addObserver(_ observer        : Any,
                     selector aSelector: Selector,
                     name aName        : NSNotification.Name?,
                     object anObject   : Any?)
    
    func post(name aName: NSNotification.Name, object anObject: Any?)
}

public protocol UserDefaultsProtocol
{
    func valueExists(forKey key: String) -> Bool
    
    func integer(forKey defaultName: String) -> Int
    func setValue(_ value: Any?, forKey key: String)
}

public protocol DarkModeProtocol
{
    var Style                  : AppearanceStyle { get }
    var SystemStyle            : SystemStyle { get }
    
    dynamic var StyleObservable: Int { get }
}

extension UserDefaults      : UserDefaultsProtocol { }
extension NotificationCenter: NotificationCenterProtocol { }
extension DarkMode          : DarkModeProtocol { }

// MARK: - Other helpers

public func rgba255(_ red  : CGFloat,
                    _ green: CGFloat,
                    _ blue : CGFloat,
                    _ alpha: CGFloat = 1.0) -> UIColor
{
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
}

public extension UIColor
{
    var RGBA255: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red*255, green*255, blue*255, alpha)
    }
}

extension UIColor
{
    ///
    /// Used only for unit testing to take control of selecting a color scheme.
    ///
    /// If it is true and if #available(iOS 13.0, *) is also true, the branch with the color scheme for iOS 13 and higher will be selected,
    /// otherwise if it is false the color scheme for iOS 12 and lower will be selected at any way.
    ///
    internal static var _iOS13InUseAndHigherOnly: Bool = true
}

extension UserDefaults
{
    public func valueExists(forKey key: String) -> Bool
    {
        return object(forKey: key) != nil
    }
}
