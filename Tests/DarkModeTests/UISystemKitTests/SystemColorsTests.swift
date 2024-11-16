//
//  SystemColorsTests.swift
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
// swiftlint:disable file_length
//

import XCTest

@testable import PerseusDarkMode

final class SystemColorsAdaptedTests: XCTestCase {

// MARK: - Foreground

    func test_perseusRed() {

        // arrange

        let light = rgba255(255, 59, 48)
        let dark = rgba255(255, 69, 58)

        // verify

        ColorVerifier.verify(required: .perseusRed, light, dark)
    }

    func test_perseusOrange() {

        // arrange

        let light = rgba255(255, 149, 0)
        let dark = rgba255(255, 159, 10)

        // verify

        ColorVerifier.verify(required: .perseusOrange, light, dark)
    }

    func test_perseusYellow() {

        // arrange

        let light = rgba255(255, 204, 0)
        let dark = rgba255(255, 214, 10)

        // verify

        ColorVerifier.verify(required: .perseusYellow, light, dark)
    }

    func test_perseusGreen() {

        // arrange

        let light = rgba255(52, 199, 89)
        let dark = rgba255(48, 209, 88)

        // verify

        ColorVerifier.verify(required: .perseusGreen, light, dark)
    }

    func test_systemMint_Adapted() {

        // arrange

        let light = rgba255(0, 199, 190)
        let dark = rgba255(102, 212, 207)

        // varify

        ColorVerifier.verify(required: .perseusMint, light, dark)
    }

    func test_perseusTeal() {

        // arrange

        let light = rgba255(48, 176, 199)
        let dark = rgba255(64, 200, 224)

        // verify

        ColorVerifier.verify(required: .perseusTeal, light, dark)
    }

    func test_perseusCyan() {

        // arrange

        let light = rgba255(50, 173, 230)
        let dark = rgba255(100, 210, 255)

        // verify

        ColorVerifier.verify(required: .perseusCyan, light, dark)
    }

    func test_perseusBlue() {

        // arrange

        let light = rgba255(0, 122, 255)
        let dark = rgba255(10, 132, 255)

        // verify

        ColorVerifier.verify(required: .perseusBlue, light, dark)
    }

    func test_perseusIndigo() {

        // arrange

        let light = rgba255(88, 86, 214)
        let dark = rgba255(94, 92, 230)

        // verify

        ColorVerifier.verify(required: .perseusIndigo, light, dark)
    }

    func test_perseusPurple() {

        // arrange

        let light = rgba255(175, 82, 222)
        let dark = rgba255(191, 90, 242)

        // verify

        ColorVerifier.verify(required: .perseusPurple, light, dark)
    }

    func test_perseusPink() {

        // arrange

        let light = rgba255(255, 45, 85)
        let dark = rgba255(255, 55, 95)

        // verify

        ColorVerifier.verify(required: .perseusPink, light, dark)
    }

    func test_perseusBrown() {

        // arrange

        let light = rgba255(162, 132, 94)
        let dark = rgba255(172, 142, 104)

        // verify

        ColorVerifier.verify(required: .perseusBrown, light, dark)
    }

    func test_perseusGray() {

        // arrange

        let light = rgba255(142, 142, 147)
        let dark = rgba255(142, 142, 147)

        // verify

        ColorVerifier.verify(required: .perseusGray, light, dark)
    }

    func test_perseusGray2() {

        // arrange

        let light = rgba255(174, 174, 178)
        let dark = rgba255(99, 99, 102)

        // verify

        ColorVerifier.verify(required: .perseusGray2, light, dark)
    }

    func test_perseusGray3() {

        // arrange

        let light = rgba255(199, 199, 204)
        let dark = rgba255(72, 72, 74)

        // verify

        ColorVerifier.verify(required: .perseusGray3, light, dark)
    }

    func test_perseusGray4() {

        // arrange

        let light = rgba255(209, 209, 214)
        let dark = rgba255(58, 58, 60)

        // verify

        ColorVerifier.verify(required: .perseusGray4, light, dark)
    }

    func test_perseusGray5() {

        // arrange

        let light = rgba255(229, 229, 234)
        let dark = rgba255(44, 44, 46)

        // verify

        ColorVerifier.verify(required: .perseusGray5, light, dark)
    }

    func test_perseusGray6() {

        // arrange

        let light = rgba255(242, 242, 247)
        let dark = rgba255(28, 28, 30)

        // verify

        ColorVerifier.verify(required: .perseusGray6, light, dark)
    }
}
