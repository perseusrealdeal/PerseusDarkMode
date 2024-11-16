//
//  SemanticColorsTests.swift
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

final class SemanticColorsTests: XCTestCase {

// MARK: - Foreground Colors

    func test_labelPerseus() {

        // arrange

        let light = rgba255(0, 0, 0)
        let dark = rgba255(255, 255, 255)

        // verify

        ColorVerifier.verify(required: .labelPerseus, light, dark)
    }

    func test_secondaryLabelPerseus() {

        // arrange

        let light = rgba255(60, 60, 67, 0.6)
        let dark = rgba255(235, 235, 245, 0.6)

        // verify

        ColorVerifier.verify(required: .secondaryLabelPerseus, light, dark)
    }

    func test_tertiaryLabelPerseus() {

        // arrange

        let light = rgba255(60, 60, 67, 0.3)
        let dark = rgba255(235, 235, 245, 0.3)

        // verify

        ColorVerifier.verify(required: .tertiaryLabelPerseus, light, dark)
    }

    func test_quaternaryLabelPerseus() {

        // arrange

        let light = rgba255(60, 60, 67, 0.18)
        let dark = rgba255(235, 235, 245, 0.16)

        // verify

        ColorVerifier.verify(required: .quaternaryLabelPerseus, light, dark)
    }

    func test_placeholderTextPerseus() {

        // arrange

        let light = rgba255(60, 60, 67, 0.3)
        let dark = rgba255(235, 235, 245, 0.3)

        // verify

        ColorVerifier.verify(required: .placeholderTextPerseus, light, dark)
    }

    func test_separatorPerseus() {

        // arrange

        let light = rgba255(60, 60, 67, 0.29)
        let dark = rgba255(84, 84, 88, 0.6)

        // verify

        ColorVerifier.verify(required: .separatorPerseus, light, dark)
    }

    func test_opaqueSeparatorPerseus() {

        // arrange

        let light = rgba255(198, 198, 200)
        let dark = rgba255(56, 56, 58)

        // verify

        ColorVerifier.verify(required: .opaqueSeparatorPerseus, light, dark)
    }

    func test_linkPerseus() {

        // arrange

        let light = rgba255(0, 122, 255)
        let dark = rgba255(9, 132, 255)

        // verify

        ColorVerifier.verify(required: .linkPerseus, light, dark)
    }

    func test_systemFillPerseus() {

        // arrange

        let light = rgba255(120, 120, 128, 0.2)
        let dark = rgba255(120, 120, 128, 0.36)

        // verify

        ColorVerifier.verify(required: .systemFillPerseus, light, dark)
    }

    func test_secondarySystemFillPerseus() {

        // arrange

        let light = rgba255(120, 120, 128, 0.16)
        let dark = rgba255(120, 120, 128, 0.32)

        // verify

        ColorVerifier.verify(required: .secondarySystemFillPerseus, light, dark)
    }

    func test_tertiarySystemFillPerseus() {

        // arrange

        let light = rgba255(118, 118, 128, 0.12)
        let dark = rgba255(118, 118, 128, 0.24)

        // verify

        ColorVerifier.verify(required: .tertiarySystemFillPerseus, light, dark)
    }

    func test_quaternarySystemFillPerseus() {

        // arrange

        let light = rgba255(116, 116, 128, 0.08)
        let dark = rgba255(118, 118, 128, 0.18)

        // verify

        ColorVerifier.verify(required: .quaternarySystemFillPerseus, light, dark)
    }

// MARK: - Background Colors

    func test_systemBackgroundPerseus() {

        // arrange

        let light = rgba255(255, 255, 255)
        let dark = rgba255(28, 28, 30)

        // verify

        ColorVerifier.verify(required: .systemBackgroundPerseus, light, dark)
    }

    func test_secondarySystemBackgroundPerseus() {

        // arrange

        let light = rgba255(242, 242, 247)
        let dark = rgba255(44, 44, 46)

        // verify

        ColorVerifier.verify(required: .secondarySystemBackgroundPerseus, light, dark)
    }

    func test_tertiarySystemBackgroundPerseus() {

        // arrange

        let light = rgba255(255, 255, 255)
        let dark = rgba255(58, 58, 60)

        // verify

        ColorVerifier.verify(required: .tertiarySystemBackgroundPerseus, light, dark)
    }

    func test_systemGroupedBackgroundPerseus() {

        // arrange

        let light = rgba255(242, 242, 247)
        let dark = rgba255(28, 28, 30)

        // verify

        ColorVerifier.verify(required: .systemGroupedBackgroundPerseus, light, dark)
    }

    func test_secondarySystemGroupedBackgroundPerseus() {

        // arrange

        let light = rgba255(255, 255, 255)
        let dark = rgba255(44, 44, 46)

        // verify

        ColorVerifier.verify(required: .secondarySystemGroupedBackgroundPerseus, light, dark)
    }

    func test_tertiarySystemGroupedBackgroundPerseus() {

        // arrange

        let light = rgba255(242, 242, 247)
        let dark = rgba255(58, 58, 60)

        // verify

        ColorVerifier.verify(required: .tertiarySystemGroupedBackgroundPerseus, light, dark)
    }
}
