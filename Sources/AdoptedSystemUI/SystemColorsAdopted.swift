//
// SystemColorsAdopted.swift
// AdoptedSystemUI
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
        if #available(iOS 13.0, *) { return .systemRed }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 1.0, green: 59/255, blue: 48/255, alpha: 1.0) :
            UIColor(red: 1.0, green: 69/255, blue: 58/255, alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM ORANGE
    ///
    public static var systemOrange_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .systemOrange }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 1.0, green: 149/255, blue: 0.0,    alpha: 1.0) :
            UIColor(red: 1.0, green: 159/255, blue: 10/255, alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM YELLOW
    ///
    public static var systemYellow_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .systemYellow }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 1.0, green: 204/255, blue: 0.0,    alpha: 1.0) :
            UIColor(red: 1.0, green: 214/255, blue: 10/255, alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM GREEN
    ///
    public static var systemGreen_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .systemGreen }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1.0) :
            UIColor(red: 48/255, green: 209/255, blue: 88/255, alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM MINT
    ///
    public static var systemMint_Adapted: UIColor
    {
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 0.0,     green: 199/255, blue: 190/255, alpha: 1.0) :
            UIColor(red: 102/255, green: 212/255, blue: 207/255, alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM TEAL
    ///
    public static var systemTeal_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .systemTeal }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 48/255, green: 176/255, blue: 199/255, alpha: 1.0) :
            UIColor(red: 64/255, green: 200/255, blue: 224/255, alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM CYAN
    ///
    public static var systemCyan_Adapted: UIColor
    {
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 50/255,  green: 173/255, blue: 230/255, alpha: 1.0) :
            UIColor(red: 100/255, green: 210/255, blue: 1.0,     alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM BLUE
    ///
    public static var systemBlue_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .systemBlue }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 0.0,    green: 122/255, blue: 1.0, alpha: 1.0) :
            UIColor(red: 10/255, green: 132/255, blue: 1.0, alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM INDIGO
    ///
    public static var systemIndigo_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .systemIndigo }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 88/255, green: 86/255, blue: 214/255, alpha: 1.0) :
            UIColor(red: 94/255, green: 92/255, blue: 230/255, alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM PURPLE
    ///
    public static var systemPurple_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .systemPurple }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 175/255, green: 82/255, blue: 222/255, alpha: 1.0) :
            UIColor(red: 191/255, green: 90/255, blue: 242/255, alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM PINK
    ///
    public static var systemPink_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return .systemPink }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 1.0, green: 45/255, blue: 85/255, alpha: 1.0) :
            UIColor(red: 1.0, green: 55/255, blue: 95/255, alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM BROWN
    ///
    public static var systemBrown_Adapted: UIColor
    {
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 162/255, green: 132/255, blue: 94/255,  alpha: 1.0) :
            UIColor(red: 172/255, green: 142/255, blue: 104/255, alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM GRAY
    ///
    public static var systemGray_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return systemGray }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1.0) :
            UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM GRAY 2
    ///
    public static var systemGray2_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return systemGray2 }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 174/255, green: 174/255, blue: 178/255, alpha: 1.0) :
            UIColor(red: 99/255,  green: 99/255,  blue: 102/255, alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM GRAY 3
    ///
    public static var systemGray3_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return systemGray3 }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 199/255, green: 199/255, blue: 204/255, alpha: 1.0) :
            UIColor(red: 72/255,  green: 72/255,  blue: 74/255,  alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM GRAY 4
    ///
    public static var systemGray4_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return systemGray4 }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1.0) :
            UIColor(red: 58/255,  green: 58/255,  blue: 60/255,  alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM GRAY 5
    ///
    public static var systemGray5_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return systemGray5 }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1.0) :
            UIColor(red: 44/255,  green: 44/255,  blue: 46/255,  alpha: 1.0)
        
        return color
    }
    
    ///
    /// SYSTEM GRAY 6
    ///
    public static var systemGray6_Adapted: UIColor
    {
        if #available(iOS 13.0, *) { return systemGray6 }
        
        let color = AppearanceService.shared.Style == .light ?
            
            UIColor(red: 199/255, green: 199/255, blue: 204/255, alpha: 1.0) :
            UIColor(red: 28/255,  green: 28/255,  blue: 30/255,  alpha: 1.0)
        
        return color
    }
}
