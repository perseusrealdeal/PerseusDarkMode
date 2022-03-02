//
// DarkModeTests.swift
// DarkModeTests
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

import XCTest
@testable import PerseusDarkMode
@testable import AdoptedSystemUI

final class DarkModeTests: XCTestCase
{
    func testInit()
    {
        XCTAssertFalse(AppearanceService.shared.isEnabled)
        
    }
}
