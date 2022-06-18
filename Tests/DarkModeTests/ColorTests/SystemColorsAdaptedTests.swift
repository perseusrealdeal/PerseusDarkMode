//
//  SystemColorsAdaptedTests.swift
//  DarkModeTests
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

import XCTest
@testable import PerseusDarkMode
@testable import AdaptedSystemUI

final class SystemColorsAdaptedTests: XCTestCase
{
    // MARK: - Tests for Foreground

    func test_systemRed_Adapted()
    {
        let light = rgba255(255, 59, 48)
        let dark = rgba255(255, 69, 58)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemRed, nil, nil, .systemRed)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemRed, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemOrange_Adapted()
    {
        let light = rgba255(255, 149, 0)
        let dark = rgba255(255, 159, 10)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemOrange, nil, nil, .systemOrange)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemOrange, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemYellow_Adapted()
    {
        let light = rgba255(255, 204, 0)
        let dark = rgba255(255, 214, 10)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemYellow, nil, nil, .systemYellow)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemYellow, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemGreen_Adapted()
    {
        let light = rgba255(52, 199, 89)
        let dark = rgba255(48, 209, 88)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemGreen, nil, nil, .systemGreen)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemGreen, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemMint_Adapted()
    {
        let light = rgba255(0, 199, 190)
        let dark = rgba255(102, 212, 207)

        if #available(iOS 15.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemMint, nil, nil, .systemMint)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemMint, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 15 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemTeal_Adapted()
    {
        let light = rgba255(48, 176, 199)
        let dark = rgba255(64, 200, 224)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemTeal, nil, nil, .systemTeal)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemTeal, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemCyan_Adapted()
    {
        let light = rgba255(50, 173, 230)
        let dark = rgba255(100, 210, 255)

        if #available(iOS 15.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemCyan, nil, nil, .systemCyan)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemCyan, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 15 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemBlue_Adapted()
    {
        let light = rgba255(0, 122, 255)
        let dark = rgba255(10, 132, 255)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemBlue, nil, nil, .systemBlue)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemBlue, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemIndigo_Adapted()
    {
        let light = rgba255(88, 86, 214)
        let dark = rgba255(94, 92, 230)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemIndigo, nil, nil, .systemIndigo)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemIndigo, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemPurple_Adapted()
    {
        let light = rgba255(175, 82, 222)
        let dark = rgba255(191, 90, 242)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemPurple, nil, nil, .systemPurple)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemPurple, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemPink_Adapted()
    {
        let light = rgba255(255, 45, 85)
        let dark = rgba255(255, 55, 95)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemPink, nil, nil, .systemPink)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemPink, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemBrown_Adapted()
    {
        let light = rgba255(162, 132, 94)
        let dark = rgba255(172, 142, 104)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemBrown, nil, nil, .systemBrown)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemBrown, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemGray_Adapted()
    {
        let light = rgba255(142, 142, 147)
        let dark = rgba255(142, 142, 147)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemGray, nil, nil, .systemGray)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemGray, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemGray2_Adapted()
    {
        let light = rgba255(174, 174, 178)
        let dark = rgba255(99, 99, 102)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemGray2, nil, nil, .systemGray2)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemGray2, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemGray3_Adapted()
    {
        let light = rgba255(199, 199, 204)
        let dark = rgba255(72, 72, 74)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemGray3, nil, nil, .systemGray3)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemGray3, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemGray4_Adapted()
    {
        let light = rgba255(209, 209, 214)
        let dark = rgba255(58, 58, 60)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemGray4, nil, nil, .systemGray4)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemGray4, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemGray5_Adapted()
    {
        let light = rgba255(229, 229, 234)
        let dark = rgba255(44, 44, 46)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemGray5, nil, nil, .systemGray5)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemGray5, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }

    func test_systemGray6_Adapted()
    {
        let light = rgba255(242, 242, 247)
        let dark = rgba255(28, 28, 30)

        if #available(iOS 13.0, *)
        {
            UIColor._iOS13InUseAndHigherOnly = true
            ColorVerifier.verify(requirement: .systemGray6, nil, nil, .systemGray6)

            UIColor._iOS13InUseAndHigherOnly = false
            ColorVerifier.verify(requirement: .systemGray6, light, dark, nil)
        }
        else
        {
            XCTFail("Test suit was designed for runing on iOS 13 and higher only!")
        }

        UIColor._iOS13InUseAndHigherOnly = true
    }
}
