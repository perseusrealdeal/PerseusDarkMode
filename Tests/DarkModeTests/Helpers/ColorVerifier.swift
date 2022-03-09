//
// ColorVerifier.swift
// DarkModeTests
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

import XCTest
@testable import PerseusDarkMode
@testable import AdaptedSystemUI

final class ColorVerifier
{
    class func verify(requirement    : ColorRequirement,
                      _ requiredLight: UIColor?,
                      _ requiredDark : UIColor?,
                      _ iOS13        : UIColor?,
                      file           : StaticString = #file,
                      line           : UInt = #line)
    {
        if #available(iOS 13.0, *), iOS13 != nil
        {
            XCTAssertEqual(requirement.color, iOS13)
        }
        else
        {
            AppearanceService.shared.DarkModeUserChoice = .off
            AppearanceService.makeAppearanceUp()
            
            XCTAssertEqual(requirement.color, requiredLight)
            
            AppearanceService.shared.DarkModeUserChoice = .on
            AppearanceService.makeAppearanceUp()
            
            XCTAssertEqual(requirement.color, requiredDark)
        }
    }
}
