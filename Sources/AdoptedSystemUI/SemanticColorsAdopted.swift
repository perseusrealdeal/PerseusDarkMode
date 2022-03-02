// 
// SemanticColorsAdopted.swift
// AdoptedSystemUI
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

import UIKit
import PerseusDarkMode

// MARK: Semantic colors

public protocol UISemanticColorsAdopted
{
    // MARK: - Foreground colors
    ///
    /// Foreground colors for static text and related elements.
    ///
    static var label_Adopted           : UIColor { get }
    
}

extension UIColor: UISemanticColorsAdopted
{
    // MARK: - Foreground colors
    
    public static var label_Adopted           : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
    }
    
}
