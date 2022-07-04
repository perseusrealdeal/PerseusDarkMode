//
//  AppearanceServiceTests.swift
//  DarkModeTests
//
//  Created by Mikhail Zhigulin in 2022.
//
//  Copyright (c) 2022 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

#if !os(macOS)
import UIKit
#endif

import XCTest
@testable import PerseusDarkMode

final class AppearanceServiceTests: XCTestCase {

    func test_init() {
        XCTAssertFalse(AppearanceService.isEnabled)
        XCTAssertFalse(AppearanceService._isEnabled)

        XCTAssertNotNil(AppearanceService.ud)
        XCTAssertNotNil(AppearanceService.nCenter)

        XCTAssertIdentical(UIView().DarkMode as AnyObject, AppearanceService.shared)
        XCTAssertIdentical(UIViewController().DarkMode as AnyObject, AppearanceService.shared)
    }

    func test_method_register_called_addObserver() {
        // arrange

        let mock = MockNotificationCenter()
        AppearanceService.nCenter = mock

        class MyView: UIView { @objc func makeUp() { } }
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
