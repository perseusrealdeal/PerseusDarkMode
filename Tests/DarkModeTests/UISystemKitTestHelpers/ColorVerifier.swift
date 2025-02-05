//
//  ColorVerifier.swift
//  PerseusDarkModeTests
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

import XCTest

@testable import PerseusDarkMode

#if os(iOS)
public typealias Color = UIColor
#elseif os(macOS)
public typealias Color = NSColor
#endif

final class ColorVerifier {
    static func verify(required: ColorRequirement, _ light: Color, _ dark: Color,
                       file: StaticString = #file,
                       line: UInt = #line) {

        DarkModeAgent.DarkModeUserChoice = .off
        XCTAssertEqual(required.color, light)

        DarkModeAgent.DarkModeUserChoice = .on
        XCTAssertEqual(required.color, dark)
    }
}
