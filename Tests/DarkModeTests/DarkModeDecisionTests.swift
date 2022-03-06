//
// DarkModeDecisionTests.swift
// DarkModeTests
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

import XCTest
@testable import PerseusDarkMode

final class DarkModeDecisionTests: XCTestCase
{
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
    func test_calculateActualStyle_with_auto_and_unspecified_should_return_default()
    {
        // arrange
        
        let userChoice = DarkModeOption.auto
        let systemStyle = SystemStyle.unspecified
        
        // act
        
        let result = DarkModeDecision.calculateActualStyle(userChoice, systemStyle)
        
        // assert
        
        XCTAssertEqual(result, DARK_MODE_STYLE_DEFAULT)
    }
    
    func test_calculateActualStyle_with_on_and_unspecified_should_return_dark()
    {
        // arrange
        
        let userChoice = DarkModeOption.on
        let systemStyle = SystemStyle.unspecified
        
        // act
        
        let result = DarkModeDecision.calculateActualStyle(userChoice, systemStyle)
        
        // assert
        
        XCTAssertEqual(result, .dark)
    }
    
    func test_calculateActualStyle_with_off_and_unspecified_should_return_light()
    {
        // arrange
        
        let userChoice = DarkModeOption.off
        let systemStyle = SystemStyle.unspecified
        
        // act
        
        let result = DarkModeDecision.calculateActualStyle(userChoice, systemStyle)
        
        // assert
        
        XCTAssertEqual(result, .light)
    }
    
    func test_calculateActualStyle_with_auto_and_light_should_return_light()
    {
        // arrange
        
        let userChoice = DarkModeOption.auto
        let systemStyle = SystemStyle.light
        
        // act
        
        let result = DarkModeDecision.calculateActualStyle(userChoice, systemStyle)
        
        // assert
        
        XCTAssertEqual(result, .light)
    }
    
    func test_calculateActualStyle_with_on_and_light_should_return_dark()
    {
        // arrange
        
        let userChoice = DarkModeOption.on
        let systemStyle = SystemStyle.light
        
        // act
        
        let result = DarkModeDecision.calculateActualStyle(userChoice, systemStyle)
        
        // assert
        
        XCTAssertEqual(result, .dark)
    }
    
    func test_calculateActualStyle_with_off_and_light_should_return_light()
    {
        // arrange
        
        let userChoice = DarkModeOption.off
        let systemStyle = SystemStyle.light
        
        // act
        
        let result = DarkModeDecision.calculateActualStyle(userChoice, systemStyle)
        
        // assert
        
        XCTAssertEqual(result, .light)
    }
    
    func test_calculateActualStyle_with_auto_and_dark_should_return_dark()
    {
        // arrange
        
        let userChoice = DarkModeOption.auto
        let systemStyle = SystemStyle.dark
        
        // act
        
        let result = DarkModeDecision.calculateActualStyle(userChoice, systemStyle)
        
        // assert
        
        XCTAssertEqual(result, .dark)
    }
    
    func test_calculateActualStyle_with_on_and_dark_should_return_dark()
    {
        // arrange
        
        let userChoice = DarkModeOption.on
        let systemStyle = SystemStyle.dark
        
        // act
        
        let result = DarkModeDecision.calculateActualStyle(userChoice, systemStyle)
        
        // assert
        
        XCTAssertEqual(result, .dark)
    }
    
    func test_calculateActualStyle_with_off_and_dark_should_return_light()
    {
        // arrange
        
        let userChoice = DarkModeOption.off
        let systemStyle = SystemStyle.dark
        
        // act
        
        let result = DarkModeDecision.calculateActualStyle(userChoice, systemStyle)
        
        // assert
        
        XCTAssertEqual(result, .light)
    }
}
