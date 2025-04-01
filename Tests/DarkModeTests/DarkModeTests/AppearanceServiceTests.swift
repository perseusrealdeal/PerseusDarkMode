//
//  AppearanceServiceTests.swift
//  DarkModeTests
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 PerseusRealDeal
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
        XCTAssertFalse(DarkModeAgent.isEnabled)
        XCTAssertFalse(DarkModeAgent.hidden_isEnabled)

        XCTAssertNotNil(DarkModeAgent.ud)
        XCTAssertNotNil(DarkModeAgent.nCenter)

        let viewDarkMode = View().DarkMode as AnyObject
        let videwControllerDarkMode = ViewController().DarkMode as AnyObject
        let sharedDarkMode = DarkModeAgent.shared as AnyObject

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
        DarkModeAgent.nCenter = mock

        class MyView: View { @objc func makeUp() { } }

        let view = MyView()

        // act

        DarkModeAgent.register(stakeholder: view, selector: #selector(view.makeUp))

        // assert

        mock.verifyRegisterObserver(observer: view, selector: #selector(view.makeUp))
    }

    func test_method_makeAppearanceUp_called_post_and_isEnabled_true() {

        // arrange

        let mock = MockNotificationCenter()
        DarkModeAgent.nCenter = mock

        // act

        DarkModeAgent.makeUp()

        // assert

        mock.verifyPost(name: .MakeAppearanceUpNotification)
        XCTAssertTrue(DarkModeAgent.isEnabled)
    }

#if os(macOS)
    func test_Dark_Mode_called_addObserver_once() {

        // arrange

        let mock = MockNotificationCenter()
        DarkModeAgent.distributedNCenter = mock

        let view1 = View()
        let view2 = View()

        // act

        // _ = AppearanceService.shared
        // _ = AppearanceService.shared

        _ = view1.DarkMode
        _ = view2.DarkMode

        // assert

        mock.verifyRegisterObserver(
            observer: DarkModeAgent.it,
            selector: #selector(DarkModeAgent.processAppleInterfaceThemeChanged))
    }
#endif
}
