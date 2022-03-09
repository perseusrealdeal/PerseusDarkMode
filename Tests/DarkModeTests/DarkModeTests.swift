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

final class DarkModeTests: XCTestCase
{
    func test_init()
    {
        let sut = DarkMode()
        
        XCTAssertNil(sut.userDefaults)
    }
}
