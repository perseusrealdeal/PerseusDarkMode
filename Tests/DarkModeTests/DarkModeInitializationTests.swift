//
//  DarkModeInitializationTests.swift
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

final class DarkModeInitializationTests: XCTestCase {

    func test_the_first_success() { XCTAssertTrue(true, "It's done!") }
}
