//
// DarkModeTests.swift
// DarkModeTests
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

import XCTest
@testable import PerseusDarkMode
@testable import AdaptedSystemUI

final class DarkModeTests: XCTestCase
{
    func test_Init()
    {
        XCTAssertFalse(AppearanceService.shared.isEnabled)
        
        XCTAssertIdentical(UIView().DarkMode, AppearanceService.shared)
        XCTAssertIdentical(UIViewController().DarkMode, AppearanceService.shared)
        
        XCTAssertIdentical(AppearanceService.shared.userDefaults, UserDefaults.standard)
    }
}
