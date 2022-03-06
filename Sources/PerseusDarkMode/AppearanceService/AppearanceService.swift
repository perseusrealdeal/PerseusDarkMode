//
// AppearanceService.swift
// PerseusDarkMode
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

public protocol AppearanceAdaptableElement
{
    func adaptAppearance()
}

public class AppearanceService
{
    // MARK: - Singleton
    
    public static var shared: DarkMode =
        {
            let instance = DarkMode()
            
            // Additional setup after initialisation.
            
            instance.userDefaults = UserDefaults.standard
            
            return instance
        }()
    
    private init() { }
    
    // MARK: - Subscribers
    
    private static var adaptableElements = Set<UIResponder>()
    
    // MARK: - Public API: register subscriber
    
    public static func register(_ screenElement: AppearanceAdaptableElement)
    {
        guard let element = screenElement as? UIResponder else { return }
        
        adaptableElements.insert(element)
    }
    
    // MARK: - Public API: unregister subscriber
    
    public static func unregister(_ screenElement: AppearanceAdaptableElement)
    {
        guard let element = screenElement as? UIResponder else { return }
        
        adaptableElements.remove(element)
    }
    
    // MARK: - Public API: call each subscriber to adapt appearance
    
    public static func adaptToDarkMode()
    {
        shared.isEnabled = true
        
        guard adaptableElements.isEmpty != true else { return }
        
        // Adapt system controls in according with Dark Mode
        
        if #available(iOS 13.0, *),
           let keyWindow = UIApplication.shared.keyWindow
        {
            switch AppearanceService.shared.DarkModeUserChoice
            {
            case .auto:
                keyWindow.overrideUserInterfaceStyle = .unspecified
            case .on:
                keyWindow.overrideUserInterfaceStyle = .dark
            case .off:
                keyWindow.overrideUserInterfaceStyle = .light
            }
        }
        
        // Adapt sibscriber's UI elements in according with Dark Mode
        
        adaptableElements.forEach(
            { item in
                
                if let element = item as? AppearanceAdaptableElement
                {
                    element.adaptAppearance()
                }
            })
    }
}
