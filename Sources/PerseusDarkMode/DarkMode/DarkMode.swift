//
// DarkMode.swift
// PerseusDarkMode
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

public class DarkMode: NSObject
{
    // MARK: - App's Dark Mode Style
    
    internal var _style                     :AppearanceStyle = DARK_MODE_STYLE_DEFAULT
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
