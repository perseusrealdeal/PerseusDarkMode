//
//  AppearanceServiceTests.swift
//  DarkModeTests
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.
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

        let viewDarkMode = View().DarkMode as AnyObject
        let videwControllerDarkMode = ViewController().DarkMode as AnyObject
        let sharedDarkMode = AppearanceService.shared as AnyObject

#if os(iOS)
        XCTAssertEqual(ObjectIdentifier(viewDarkMode), ObjectIdentifier(sharedDarkMode))
        XCTAssertEqual(ObjectIdentifier(videwControllerDarkMode),
                       ObjectIdentifier(sharedDarkMode))
#elseif os(macOS)
        XCTAssertEqual(viewDarkMode.objectID, sharedDarkMode.objectID)
        XCTAssertEqual(videwControllerDarkMode.objectID, sharedDarkMode.objectID)
#endif
    }

    func test_method_register_called_addObserver() {
        // arrange

        let mock = MockNotificationCenter()
        AppearanceService.nCenter = mock

        // swiftlint:disable nesting

        class MyView: View { @objc func makeUp() { } }

        // swiftlint:enable nesting

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

#if os(macOS)
    func test_Dark_Mode_called_addObserver_once() {
        // arrange

        let mock = MockNotificationCenter()
        AppearanceService.distributedNCenter = mock

        let view1 = View()
        let view2 = View()

        // act

        // _ = AppearanceService.shared
        // _ = AppearanceService.shared

        _ = view1.DarkMode
        _ = view2.DarkMode

        // assert

        mock.verifyRegisterObserver(observer: AppearanceService.it,
                                    selector: #selector(AppearanceService.modeChanged))
    }
#endif
}
