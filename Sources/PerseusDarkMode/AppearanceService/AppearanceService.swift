//
// AppearanceService.swift
// PerseusDarkMode
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

public extension Notification.Name
{
    static let makeAppearanceUpStatement = Notification.Name("makeAppearanceUpStatement")
}

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

// Local helpers

extension UserDefaults
{
    public func valueExists(forKey key: String) -> Bool
    {
        return object(forKey: key) != nil
    }
}

// MARK: Protocols used for unit testing

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

extension UserDefaults      : UserDefaultsProtocol { }
extension NotificationCenter: NotificationCenterProtocol { }
