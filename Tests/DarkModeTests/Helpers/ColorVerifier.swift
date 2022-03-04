//
// ColorVerifier.swift
// DarkModeTests
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

import UIKit
import XCTest
@testable import PerseusDarkMode
@testable import AdaptedSystemUI

final class ColorVerifier
{
    class func verify(requirement     : ColorRequirement,
                      _ requiredLight : UIColor?,
                      _ requiredDark  : UIColor?,
                      _ iOS13         : UIColor?,
                      file            : StaticString = #file,
                      line            : UInt = #line)
    {
        if #available(iOS 13.0, *), iOS13 != nil
        {
            XCTAssertEqual(requirement.color, iOS13)
        }
        else
        {
            AppearanceService.shared.DarkModeUserChoice = .off
            AppearanceService.adaptToDarkMode()
            
            XCTAssertEqual(requirement.color, requiredLight)
            
            AppearanceService.shared.DarkModeUserChoice = .on
            AppearanceService.adaptToDarkMode()
            
            XCTAssertEqual(requirement.color, requiredDark)
        }
    }
}
