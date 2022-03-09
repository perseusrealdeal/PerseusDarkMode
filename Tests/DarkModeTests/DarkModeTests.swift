//
// DarkModeTests.swift
// DarkModeTests
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

import XCTest
@testable import PerseusDarkMode

final class DarkModeTests: XCTestCase
{
    func test_DarkMode_observable()
    {
        // arrange
        
        var count     : Int = 0
        var collection: [AppearanceStyle] = []
        
        var observer:DarkModeObserver? = DarkModeObserver(AppearanceService.shared)
        observer?.action =
            { newStyle in
                
                if let style = newStyle
                {
                    collection.append(style)
                    count += 1
                }
            }
        
        // act
        
        AppearanceService.shared._style = AppearanceStyle.dark
        AppearanceService.shared._style = AppearanceStyle.light
        
        // assert
        
        XCTAssertEqual(count, 2)
        XCTAssertEqual(collection, [AppearanceStyle.dark, AppearanceStyle.light])
        
        // keep the room clean
        
        observer = nil
    }
    
    func test_DarkMode_not_observable()
    {
        // arrange
        
        var count     : Int = 0
        var collection: [AppearanceStyle] = []
        
        var observer:DarkModeObserver? = DarkModeObserver(AppearanceService.shared)
        observer?.action =
            { newStyle in
                
                if let style = newStyle
                {
                    collection.append(style)
                    count += 1
                }
            }
        
        // act
        observer = nil
        
        AppearanceService.shared._style = AppearanceStyle.dark
        AppearanceService.shared._style = AppearanceStyle.light
        
        // assert
        
        XCTAssertEqual(count, 0)
        XCTAssertEqual(collection, [])
    }
}
