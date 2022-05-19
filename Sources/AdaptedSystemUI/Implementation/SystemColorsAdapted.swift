//
//  SystemColorsAdapted.swift
//  AdaptedSystemUI
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

#if !os(macOS)
import UIKit
#endif

import PerseusDarkMode

/// Brings system colors to early iOS releases.
///
/// Each color is either native SDK color or self-made.
/// It means that for those iOS versions where a color is not released a self-made adaptation in use.
extension UIColor: SystemColorProtocol
{
    /// Red.
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
    
    /// Orange.
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
    
    /// Yeallow.
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
    
    /// Green.
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
    
    /// Mint.
    public static var systemMint_Adapted: UIColor
    {
        guard #available(iOS 15.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
            
            rgba255(0, 199, 190) : rgba255(102, 212, 207)
            
            return color
        }
        
        return .systemMint
    }
    
    /// Teal.
    public static var systemTeal_Adapted: UIColor
    {
        // .systemTeal gives unexpected color
        // in iOS 13, but meets in 15.
        //
        // Tested on iOS 13.7.
        //
        // Specification:
        // RGBA: 48, 176, 199 in Light
        // RGBA: 64, 200, 224 in Dark
        //
        // Simulator iPhone 8 (iOS 13.7):
        // RGBA: 90, 200, 250 in Light
        // RGBA: 100, 210, 255 in Dark
        //
        // LINK to .systemTeal color specification:
        // https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/
        //
        
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
            
            rgba255(48, 176, 199) : rgba255(64, 200, 224)
            
            return color
        }
        
        return .systemTeal
        
    }
    
    /// Cyan.
    public static var systemCyan_Adapted: UIColor
    {
        guard #available(iOS 15.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
            
            rgba255(50, 173, 230) : rgba255(100, 210, 255)
            
            return color
        }
        
        return .systemCyan
    }
    
    /// Blue.
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
    
    /// Indigo.
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
    
    /// Purple.
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
    
    /// Pink.
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
    
    /// Brown.
    public static var systemBrown_Adapted: UIColor
    {
        guard #available(iOS 13.0, *), _iOS13InUseAndHigherOnly else
        {
            let color = AppearanceService.shared.Style == .light ?
            
            rgba255(162, 132, 94) : rgba255(172, 142, 104)
            
            return color
        }
        
        return .systemBrown
    }
    
    /// Gray.
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
    
    /// System gray 2.
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
    
    /// System gray 3.
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
    
    /// System gray 4.
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
    
    /// System gray 5.
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
    
    /// System gray 6.
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
