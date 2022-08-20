//
//  AppearanceServiceTests.swift
//  DarkModeTests
//
//  Created by Mikhail Zhigulin in 2022.
//
//  Copyright (c) 2022 Mikhail Zhigulin of Novosibirsk.
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

/* template
#if os(iOS)

#elseif os(macOS)

#endif
*/

import XCTest
@testable import PerseusDarkMode

final class AppearanceServiceTests: XCTestCase {

    func test_init() {
        XCTAssertFalse(AppearanceService.isEnabled)
        XCTAssertFalse(AppearanceService._isEnabled)

        XCTAssertNotNil(AppearanceService.ud)
        XCTAssertNotNil(AppearanceService.nCenter)

#if os(iOS)
        XCTAssertIdentical(UIView().DarkMode as AnyObject, AppearanceService.shared)
        XCTAssertIdentical(UIViewController().DarkMode as AnyObject, AppearanceService.shared)
#elseif os(macOS)
        XCTAssertIdentical(NSView().DarkMode as AnyObject, AppearanceService.shared)
        XCTAssertIdentical(NSViewController().DarkMode as AnyObject, AppearanceService.shared)
#endif
    }

    func test_method_register_called_addObserver() {
        // arrange

        let mock = MockNotificationCenter()
        AppearanceService.nCenter = mock

#if os(iOS)
        class MyView: UIView { @objc func makeUp() { } }
#elseif os(macOS)
        class MyView: NSView { @objc func makeUp() { } }
#endif

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

        mock.verifyPost(name: .makeAppearanceUpNotification)
        XCTAssertTrue(AppearanceService.isEnabled)
    }
}
