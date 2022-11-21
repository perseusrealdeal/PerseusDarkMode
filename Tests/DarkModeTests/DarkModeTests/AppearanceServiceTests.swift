//
//  AppearanceServiceTests.swift
//  DarkModeTests
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright (c) 7530 - 7531 Mikhail Zhigulin of Novosibirsk.
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

#if os(iOS)
public typealias View = UIView
public typealias ViewController = UIViewController
#elseif os(macOS)
public typealias View = NSView
public typealias ViewController = NSViewController
#endif

import XCTest
@testable import PerseusDarkMode

final class AppearanceServiceTests: XCTestCase {

    func test_init() {
        XCTAssertFalse(AppearanceService.isEnabled)
        XCTAssertFalse(AppearanceService.hidden_isEnabled)

        XCTAssertNotNil(AppearanceService.ud)
        XCTAssertNotNil(AppearanceService.nCenter)

        XCTAssertIdentical(View().DarkMode as AnyObject, AppearanceService.shared)
        XCTAssertIdentical(ViewController().DarkMode as AnyObject, AppearanceService.shared)
    }

    func test_method_register_called_addObserver() {
        // arrange

        let mock = MockNotificationCenter()
        AppearanceService.nCenter = mock

        class MyView: View { @objc func makeUp() { } }

        let view = MyView()

        // act

        AppearanceService.register(stakeholder: view, selector: #selector(view.makeUp))

        // assert

        mock.verifyRegisterObserver(observer: view, selector: #selector(view.makeUp))
    }

    func test_method_makeAppearanceUp_called_post_and_isEnabled_true() {
        // arrange

        let mock = MockNotificationCenter()
        AppearanceService.nCenter = mock

        // act

        AppearanceService.makeUp()

        // assert

        mock.verifyPost(name: .MakeAppearanceUpNotification)
        XCTAssertTrue(AppearanceService.isEnabled)
    }
}
