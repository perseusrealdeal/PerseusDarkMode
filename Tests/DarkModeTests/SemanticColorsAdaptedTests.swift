//
// SemanticColorsAdaptedTests.swift
// DarkModeTests
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

import XCTest
@testable import PerseusDarkMode
@testable import AdaptedSystemUI

final class SemanticColorsAdaptedTests: XCTestCase
{
    // MARK: - Tests for Foreground
    
    func test_label_Adapted()
    {
        let light = rgba255(255, 255, 255)
        let dark = rgba255(0, 0, 0)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .label, nil, nil, .label) }
        else
        { ColorVerifier.verify(requirement: .label, light, dark, nil) }
    }
    
    func test_secondaryLabel_Adapted()
    {
        let light = rgba255(235, 235, 245, 0.6)
        let dark = rgba255(60, 60, 67, 0.6)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .secondaryLabel, nil, nil, .secondaryLabel) }
        else
        { ColorVerifier.verify(requirement: .secondaryLabel, light, dark, nil) }
    }
    
    func test_tertiaryLabel_Adapted()
    {
        let light = rgba255(235, 235, 245, 0.3)
        let dark = rgba255(60, 60, 67, 0.3)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .tertiaryLabel, nil, nil, .tertiaryLabel) }
        else
        { ColorVerifier.verify(requirement: .tertiaryLabel, light, dark, nil) }
    }
    
    func test_quaternaryLabel_Adapted()
    {
        let light = rgba255(235, 235, 245, 0.18)
        let dark = rgba255(60, 60, 67, 0.18)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .quaternaryLabel, nil, nil, .quaternaryLabel) }
        else
        { ColorVerifier.verify(requirement: .quaternaryLabel, light, dark, nil) }
    }
    
    func test_placeholderText_Adapted()
    {
        let light = rgba255(235, 235, 245, 0.3)
        let dark = rgba255(60, 60, 67, 0.3)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .placeholderText, nil, nil, .placeholderText) }
        else
        { ColorVerifier.verify(requirement: .placeholderText, light, dark, nil) }
    }
    
    func test_separator_Adapted()
    {
        let light = rgba255(84, 84, 88, 0.6)
        let dark = rgba255(60, 60, 67, 0.29)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .separator, nil, nil, .separator) }
        else
        { ColorVerifier.verify(requirement: .separator, light, dark, nil) }
    }
    
    func test_opaqueSeparator_Adapted()
    {
        let light = rgba255(56, 56, 58)
        let dark = rgba255(198, 198, 200)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .opaqueSeparator, nil, nil, .opaqueSeparator) }
        else
        { ColorVerifier.verify(requirement: .opaqueSeparator, light, dark, nil) }
    }
    
    func test_link_Adapted()
    {
        let light = rgba255(9, 132, 255)
        let dark = rgba255(0, 122, 255)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .link, nil, nil, .link) }
        else
        { ColorVerifier.verify(requirement: .link, light, dark, nil) }
    }
    
    func test_systemFill_Adapted()
    {
        let light = rgba255(120, 120, 128, 0.36)
        let dark = rgba255(120, 120, 128, 0.2)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .systemFill, nil, nil, .systemFill) }
        else
        { ColorVerifier.verify(requirement: .systemFill, light, dark, nil) }
    }
    
    func test_secondarySystemFill_Adapted()
    {
        let light = rgba255(120, 120, 128, 0.32)
        let dark = rgba255(120, 120, 128, 0.16)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .secondarySystemFill, nil, nil, .secondarySystemFill) }
        else
        { ColorVerifier.verify(requirement: .secondarySystemFill, light, dark, nil) }
    }
    
    func test_tertiarySystemFill_Adapted()
    {
        let light = rgba255(118, 118, 128, 0.24)
        let dark = rgba255(118, 118, 128, 0.12)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .tertiarySystemFill, nil, nil, .tertiarySystemFill) }
        else
        { ColorVerifier.verify(requirement: .tertiarySystemFill, light, dark, nil) }
    }
    
    func test_quaternarySystemFill_Adapted()
    {
        let light = rgba255(118, 118, 128, 0.18)
        let dark = rgba255(116, 116, 128, 0.08)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .quaternarySystemFill, nil, nil, .quaternarySystemFill) }
        else
        { ColorVerifier.verify(requirement: .quaternarySystemFill, light, dark, nil) }
    }
    
    // MARK: - Tests for Background
    
    func test_systemBackground_Adapted()
    {
        let light = rgba255(0, 0, 0)
        let dark = rgba255(255, 255, 255)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .systemBackground, nil, nil, .systemBackground) }
        else
        { ColorVerifier.verify(requirement: .systemBackground, light, dark, nil) }
    }
    
    func test_secondarySystemBackground_Adapted()
    {
        let light = rgba255(28, 28, 30)
        let dark = rgba255(242, 242, 247)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .secondarySystemBackground, nil, nil, .secondarySystemBackground) }
        else
        { ColorVerifier.verify(requirement: .secondarySystemBackground, light, dark, nil) }
    }
    
    func test_tertiarySystemBackground_Adapted()
    {
        let light = rgba255(44, 44, 46)
        let dark = rgba255(255, 255, 255)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .tertiarySystemBackground, nil, nil, .tertiarySystemBackground) }
        else
        { ColorVerifier.verify(requirement: .tertiarySystemBackground, light, dark, nil) }
    }
    
    func test_systemGroupedBackground_Adapted()
    {
        let light = rgba255(0, 0, 0)
        let dark = rgba255(242, 242, 247)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .systemGroupedBackground, nil, nil, .systemGroupedBackground) }
        else
        { ColorVerifier.verify(requirement: .systemGroupedBackground, light, dark, nil) }
    }
    
    func test_secondarySystemGroupedBackground_Adapted()
    {
        let light = rgba255(28, 28, 30)
        let dark = rgba255(255, 255, 255)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .secondarySystemGroupedBackground, nil, nil, .secondarySystemGroupedBackground) }
        else
        { ColorVerifier.verify(requirement: .secondarySystemGroupedBackground, light, dark, nil) }
    }
    
    func test_tertiarySystemGroupedBackground_Adapted()
    {
        let light = rgba255(44, 44, 46)
        let dark = rgba255(242, 242, 247)
        
        if #available(iOS 13.0, *)
        { ColorVerifier.verify(requirement: .tertiarySystemGroupedBackground, nil, nil, .tertiarySystemGroupedBackground) }
        else
        { ColorVerifier.verify(requirement: .tertiarySystemGroupedBackground, light, dark, nil) }
    }
}
