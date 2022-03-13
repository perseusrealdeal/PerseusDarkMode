//
// AppearanceServiceTests.swift
// DarkModeTests
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

import XCTest
@testable import PerseusDarkMode

final class AppearanceServiceTests: XCTestCase
{
    func test_init()
    {
        XCTAssertFalse(AppearanceService.isEnabled)
        XCTAssertFalse(AppearanceService._isEnabled)
        
        XCTAssertNotNil(AppearanceService.ud)
        XCTAssertNotNil(AppearanceService.nCenter)
        
        XCTAssertIdentical(UIView().DarkMode as AnyObject, AppearanceService.shared)
        XCTAssertIdentical(UIViewController().DarkMode as AnyObject, AppearanceService.shared)
    }
    
    func test_method_register_called_addObserver()
    {
        // arrange
        
        let mock = MockNotificationCenter()
        AppearanceService.nCenter = mock
        
        class MyView: UIView { @objc func test() { } }
        let view = MyView()
        
        // act
        
        AppearanceService.register(observer: view, selector: #selector(view.test))
        
        // assert
        
        mock.verifyRegisterObserver(observer: view, selector: #selector(view.test))
    }
    
    func test_method_makeAppearanceUp_called_post_and_isEnabled_true()
    {
        // arrange
        
        let mock = MockNotificationCenter()
        AppearanceService.nCenter = mock
        
        // act
        
        AppearanceService.makeUp()
        
        // assert
        
        mock.verifyPost(name: .makeAppearanceUpStatement)
        XCTAssertTrue(AppearanceService.isEnabled)
    }
}
