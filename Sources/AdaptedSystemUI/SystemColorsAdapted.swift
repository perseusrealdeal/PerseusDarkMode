//
// SystemColorsAdapted.swift
// AdaptedSystemUI
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

import UIKit
import PerseusDarkMode

// MARK: System colors

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

extension UIColor: UISystemColorsAdapted
{
    ///
    /// SYSTEM RED
    ///
    public static var systemRed_Adapted: UIColor
    {
        guard #available(iOS 13.0, *) else
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
        guard #available(iOS 13.0, *) else
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
        guard #available(iOS 13.0, *) else
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
        guard #available(iOS 13.0, *) else
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
        let color = AppearanceService.shared.Style == .light ?
            
            rgba255(0, 199, 190) : rgba255(102, 212, 207)
        
        return color
    }
    
    ///
    /// SYSTEM TEAL
    ///
    public static var systemTeal_Adapted: UIColor
    {
        guard #available(iOS 13.0, *) else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(48, 176, 199) : rgba255(64, 200, 224)
            
            return color
        }
        
        return .systemTeal
    }
    
    ///
    /// SYSTEM CYAN
    ///
    public static var systemCyan_Adapted: UIColor
    {
        let color = AppearanceService.shared.Style == .light ?
            
            rgba255(50, 173, 230) : rgba255(100, 210, 255)
        
        return color
    }
    
    ///
    /// SYSTEM BLUE
    ///
    public static var systemBlue_Adapted: UIColor
    {
        guard #available(iOS 13.0, *) else
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
        guard #available(iOS 13.0, *) else
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
        guard #available(iOS 13.0, *) else
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
        guard #available(iOS 13.0, *) else
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
        let color = AppearanceService.shared.Style == .light ?
            
            rgba255(162, 132, 94) : rgba255(172, 142, 104)
        
        return color
    }
    
    ///
    /// SYSTEM GRAY
    ///
    public static var systemGray_Adapted: UIColor
    {
        guard #available(iOS 13.0, *) else
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
        guard #available(iOS 13.0, *) else
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
        guard #available(iOS 13.0, *) else
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
        guard #available(iOS 13.0, *) else
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
        guard #available(iOS 13.0, *) else
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
        guard #available(iOS 13.0, *) else
        {
            let color = AppearanceService.shared.Style == .light ?
                
                rgba255(242, 242, 247) : rgba255(28, 28, 30)
            
            return color
        }
        
        return .systemGray6
    }
}
