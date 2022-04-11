//
// DarkModeImageViewTests.swift
// DarkModeTests
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

import XCTest
@testable import PerseusDarkMode

final class DarkModeImageViewTests: XCTestCase
{
    func test_init()
    {
        let sut = DarkModeImageView()
        
        XCTAssertNil(sut.imageLight)
        XCTAssertNil(sut.imageDark)
        
        XCTAssertIdentical(sut.darkModeObserver.objectToObserve, AppearanceService.shared)
    }
    
    func test_setUp()
    {
        // arrange
        
        let sut = DarkModeImageView()
        
        // act
        
        sut.setUp(createImage(),
                  createImage())
        
        // assert
        
        XCTAssertNotNil(sut.imageLight)
        XCTAssertNotNil(sut.imageDark)
    }
    
    func test_setUp_image_should_be_light_if_style_is_light()
    {
        // arrange
        
        let sut = DarkModeImageView()
        
        let light = createImage()
        let dark = createImage()
        
        // act
        
        AppearanceService.shared._style = AppearanceStyle.light
        
        sut.setUp(light, dark)
        
        // assert
        
        XCTAssertEqual(sut.image, light)
    }
    
    func test_setUp_image_should_be_dark_if_style_is_dark()
    {
        // arrange
        
        let sut = DarkModeImageView()
        
        let light = createImage()
        let dark = createImage()
        
        // act
        
        AppearanceService.shared._style = AppearanceStyle.dark
        
        sut.setUp(light, dark)
        
        // assert
        
        XCTAssertEqual(sut.image, dark)
    }
    
    func test_setUp_image_should_be_light_if_style_changed_to_light()
    {
        // arrange
        
        let sut = DarkModeImageView()
        
        let light = createImage()
        let dark = createImage()
        
        // act
        
        AppearanceService.shared._style = AppearanceStyle.dark
        
        sut.setUp(light, dark)
        
        AppearanceService.shared._style = AppearanceStyle.light
        
        // assert
        
        XCTAssertEqual(sut.image, light)
    }
    
    func test_setUp_image_should_be_dark_if_style_changed_to_dark()
    {
        // arrange
        
        let sut = DarkModeImageView()
        
        let light = createImage()
        let dark = createImage()
        
        // act
        
        AppearanceService.shared._style = AppearanceStyle.light
        
        sut.setUp(light, dark)
        
        AppearanceService.shared._style = AppearanceStyle.dark
        
        // assert
        
        XCTAssertEqual(sut.image, dark)
    }
}
