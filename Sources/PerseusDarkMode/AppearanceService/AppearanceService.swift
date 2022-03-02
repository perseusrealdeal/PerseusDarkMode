//
// AppearanceService.swift
// PerseusDarkMode
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

import UIKit

public protocol AppearanceAdaptableElement
{
    func adoptAppearance()
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
    
    private static var adoptableElements = Set<UIResponder>()
    
    // MARK: - Public API: register subscriber
    
    public static func register(_ screenElement: AppearanceAdaptableElement)
    {
        guard let element = screenElement as? UIResponder else { return }
        
        adoptableElements.insert(element)
    }
    
    // MARK: - Public API: unregister subscriber
    
    public static func unregister(_ screenElement: AppearanceAdaptableElement)
    {
        guard let element = screenElement as? UIResponder else { return }
        
        adoptableElements.remove(element)
    }
    
    // MARK: - Public API: call each subscriber to adopt appearance
    
    public static func adoptToDarkMode()
    {
        shared.isEnabled = true
        
        guard adoptableElements.isEmpty != true else { return }
        
        // Adopt system controls in according with Dark Mode
        
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
        
        // Adopt sibscriber's UI elements in according with Dark Mode
        
        adoptableElements.forEach(
            { item in
                
                if let element = item as? AppearanceAdaptableElement
                {
                    element.adoptAppearance()
                }
            })
    }
}
