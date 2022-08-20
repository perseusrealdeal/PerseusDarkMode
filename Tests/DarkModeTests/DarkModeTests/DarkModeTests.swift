//
//  DarkModeTests.swift
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

import XCTest
@testable import PerseusDarkMode

final class DarkModeTests: XCTestCase {

    func test_DarkMode_observable() {
        // arrange

        var count: Int = 0
        var collection: [AppearanceStyle] = []

        var observer: DarkModeObserver? = DarkModeObserver()
        observer?.action = { newStyle in

                collection.append(newStyle)
                count += 1
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

    func test_DarkMode_not_observable() {
        // arrange

        var count: Int = 0
        var collection: [AppearanceStyle] = []

        var observer: DarkModeObserver? = DarkModeObserver()
        observer?.action = { newStyle in

                collection.append(newStyle)
                count += 1
            }

        // act

        observer = nil

        AppearanceService.shared._style = AppearanceStyle.dark
        AppearanceService.shared._style = AppearanceStyle.light

        // assert

        XCTAssertEqual(count, 0)
        XCTAssertEqual(collection, [])
    }

    func test_get_DarkModeUserChoice_when_valueExists_true() {
        // arrange

        let mockUserDefaults = MockUserDefaults()
        AppearanceService.ud = mockUserDefaults

        mockUserDefaults.isValueExists = true

        // act

        _ = AppearanceService.DarkModeUserChoice

        // assert

        mockUserDefaults.verifyInterger(name: DARK_MODE_USER_CHOICE_OPTION_KEY)

        // keep it clean for the others

        AppearanceService.ud = UserDefaults.standard
    }

    func test_get_DarkModeUserChoice_when_valueExists_false() {
        // arrange

        let mockUserDefaults = MockUserDefaults()
        AppearanceService.ud = mockUserDefaults

        mockUserDefaults.isValueExists = false

        // act

        let result = AppearanceService.DarkModeUserChoice

        // assert

        mockUserDefaults.verifyInterger()

        XCTAssertEqual(result, DARK_MODE_USER_CHOICE_DEFAULT)

        // keep it clean for the others

        AppearanceService.ud = UserDefaults.standard
    }

    func test_set_DarkModeUserChoice() {
        // arrange

        let mockUserDefaults = MockUserDefaults()
        AppearanceService.ud = mockUserDefaults

        let sut = DarkModeOption.off

        // act

        AppearanceService.DarkModeUserChoice = sut

        // assert

        mockUserDefaults.verifySetValue(value: sut.rawValue,
                                        key: DARK_MODE_USER_CHOICE_OPTION_KEY)

        // keep it clean for the others

        AppearanceService.ud = UserDefaults.standard
    }
}
