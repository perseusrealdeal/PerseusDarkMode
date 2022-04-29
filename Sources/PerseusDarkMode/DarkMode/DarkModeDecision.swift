//
// DarkModeDecision.swift
// PerseusDarkMode
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

// MARK: - Calculations

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
