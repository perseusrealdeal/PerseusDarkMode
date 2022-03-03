// 
// SemanticColorsAdapted.swift
// AdaptedSystemUI
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

import UIKit
import PerseusDarkMode

// MARK: Semantic colors

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
    static var tertiarySystemFilll_Adapted : UIColor { get }
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

extension UIColor: UISemanticColorsAdapted
{
    // MARK: - Foreground
    
    ///
    /// Label Colors
    ///
    public static var label_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .label }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1.0) :
            UIColor(red: 48/255, green: 209/255, blue: 88/255, alpha: 1.0)
        
        return color
    }
    
    public static var secondaryLabel_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .secondaryLabel }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 235/255, green: 235/255, blue: 245/255, alpha: 0.6) :
            UIColor(red: 60/255,  green: 60/255,  blue: 67/255,  alpha: 0.6)
        
        return color
    }
    
    public static var tertiaryLabel_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .tertiaryLabel }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 235/255, green: 235/255, blue: 245/255, alpha: 0.3) :
            UIColor(red: 60/255,  green: 60/255,  blue: 67/255,  alpha: 0.3)
        
        return color
    }
    
    public static var quaternaryLabel_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .quaternaryLabel }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 235/255, green: 235/255, blue: 245/255, alpha: 0.18) :
            UIColor(red: 60/255,  green: 60/255,  blue: 67/255,  alpha: 0.18)
        
        return color
    }
    
    ///
    /// Text Colors
    ///
    public static var placeholderText_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .placeholderText }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 235/255, green: 235/255, blue: 245/255, alpha: 0.3) :
            UIColor(red: 60/255,  green: 60/255,  blue: 67/255,  alpha: 0.3)
        
        return color
    }
    
    ///
    /// Separator Colors
    ///
    public static var separator_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .separator }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 84/255, green: 84/255, blue: 88/255, alpha: 0.6) :
            UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.29)
        
        return color
    }
    
    public static var opaqueSeparator_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .opaqueSeparator }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 56/255,  green: 56/255,  blue: 58/255,  alpha: 1.0) :
            UIColor(red: 198/255, green: 198/255, blue: 200/255, alpha: 1.0)
        
        return color
    }
    
    ///
    /// Link Color
    ///
    public static var link_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .link }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 9/255, green: 132/255, blue: 1.0, alpha: 1.0) :
            UIColor(red: 0.0,   green: 122/255, blue: 1.0, alpha: 1.0)
        
        return color
    }
    
    ///
    /// Fill Colors
    ///
    public static var systemFill_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .systemFill }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 120/255, green: 120/255, blue: 128/255, alpha: 0.36) :
            UIColor(red: 120/255, green: 120/255, blue: 128/255, alpha: 0.2)
        
        return color
    }
    
    public static var secondarySystemFill_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .secondarySystemFill }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 120/255, green: 120/255, blue: 128/255, alpha: 0.32) :
            UIColor(red: 120/255, green: 120/255, blue: 128/255, alpha: 0.16)
        
        return color
    }
    
    public static var tertiarySystemFilll_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .tertiarySystemFill }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.24) :
            UIColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.12)
        
        return color
    }
    
    public static var quaternarySystemFill_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .quaternarySystemFill }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.18) :
            UIColor(red: 116/255, green: 116/255, blue: 128/255, alpha: 0.08)
        
        return color
    }
    
    // MARK: - Background
    
    ///
    /// Standard Content Background Colors
    ///
    public static var systemBackground_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .systemBackground }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) :
            UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        return color
    }
    
    public static var secondarySystemBackground_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .secondarySystemBackground }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 28/255,  green: 28/255,  blue: 30/255,  alpha: 1.0) :
            UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        
        return color
    }
    
    public static var tertiarySystemBackground_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .tertiarySystemBackground }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1.0) :
            UIColor(red: 1.0,    green: 1.0,    blue: 1.0,    alpha: 1.0)
        
        return color
    }
    
    ///
    /// Grouped Content Background Colors
    ///
    public static var systemGroupedBackground_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .systemGroupedBackground }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 0.0,     green: 0.0,     blue: 0.0,     alpha: 1.0) :
            UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        
        return color
    }
    
    public static var secondarySystemGroupedBackground_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .secondarySystemGroupedBackground }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1.0) :
            UIColor(red: 1.0,    green: 1.0,    blue: 1.0,    alpha: 1.0)
        
        return color
    }
    
    public static var tertiarySystemGroupedBackground_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .tertiarySystemGroupedBackground }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 44/255,  green: 44/255,  blue: 46/255,  alpha: 1.0) :
            UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        
        return color
    }
}
