// 
// SemanticColorsAdapted.swift
// AdaptedSystemUI
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

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
                
                rgba255(255, 255, 255) : rgba255(0, 0, 0)
            
            return color
        }
        
        return .systemBackground
    }
    
    public static var secondarySystemBackground_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(242, 242, 247) : rgba255(28, 28, 30)
            
            return color
        }
        
        return .secondarySystemBackground
    }
    
    public static var tertiarySystemBackground_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(255, 255, 255) : rgba255(44, 44, 46)
            
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
                
                rgba255(242, 242, 247) : rgba255(0, 0, 0)
            
            return color
        }
        
        return .systemGroupedBackground
    }
    
    public static var secondarySystemGroupedBackground_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(255, 255, 255) : rgba255(28, 28, 30)
            
            return color
        }
        
        return .secondarySystemGroupedBackground
    }
    
    public static var tertiarySystemGroupedBackground_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(242, 242, 247) : rgba255(44, 44, 46)
            
            return color
        }
        
        return .tertiarySystemGroupedBackground
    }
}
