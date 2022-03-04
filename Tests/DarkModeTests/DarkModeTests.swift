//
// DarkModeTests.swift
// DarkModeTests
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

import XCTest
@testable import PerseusDarkMode
@testable import AdaptedSystemUI

final class DarkModeTests: XCTestCase
{
    func test_Init()
    {
        XCTAssertFalse(AppearanceService.shared.isEnabled)
    }
}

