//
//  ColorRequirement.swift
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

import Foundation

public enum ColorRequirement {

    // MARK: - Semantics

    case labelPerseus
    case secondaryLabelPerseus
    case tertiaryLabelPerseus
    case quaternaryLabelPerseus
    case placeholderTextPerseus
    case separatorPerseus
    case opaqueSeparatorPerseus
    case linkPerseus

    case systemFillPerseus
    case secondarySystemFillPerseus
    case tertiarySystemFillPerseus
    case quaternarySystemFillPerseus

    case systemBackgroundPerseus
    case secondarySystemBackgroundPerseus
    case tertiarySystemBackgroundPerseus

    case systemGroupedBackgroundPerseus
    case secondarySystemGroupedBackgroundPerseus
    case tertiarySystemGroupedBackgroundPerseus

    // MARK: - Systems

    case perseusRed
    case perseusOrange
    case perseusYellow
    case perseusGreen
    case perseusMint
    case perseusTeal
    case perseusCyan
    case perseusBlue
    case perseusIndigo
    case perseusPurple
    case perseusPink
    case perseusBrown

    case perseusGray
    case perseusGray2
    case perseusGray3
    case perseusGray4
    case perseusGray5
    case perseusGray6

    // MARK: - Color

    var color: Color {
        switch self {
        case .labelPerseus:
            return .labelPerseus
        case .secondaryLabelPerseus:
            return .secondaryLabelPerseus
        case .tertiaryLabelPerseus:
            return .tertiaryLabelPerseus
        case .quaternaryLabelPerseus:
            return .quaternaryLabelPerseus
        case .placeholderTextPerseus:
            return .placeholderTextPerseus
        case .separatorPerseus:
            return .separatorPerseus
        case .opaqueSeparatorPerseus:
            return .opaqueSeparatorPerseus
        case .linkPerseus:
            return .linkPerseus
        case .systemFillPerseus:
            return .systemFillPerseus
        case .secondarySystemFillPerseus:
            return .secondarySystemFillPerseus
        case .tertiarySystemFillPerseus:
            return .tertiarySystemFillPerseus
        case .quaternarySystemFillPerseus:
            return .quaternarySystemFillPerseus
        case .systemBackgroundPerseus:
            return .systemBackgroundPerseus
        case .secondarySystemBackgroundPerseus:
            return .secondarySystemBackgroundPerseus
        case .tertiarySystemBackgroundPerseus:
            return .tertiarySystemBackgroundPerseus
        case .systemGroupedBackgroundPerseus:
            return .systemGroupedBackgroundPerseus
        case .secondarySystemGroupedBackgroundPerseus:
            return .secondarySystemGroupedBackgroundPerseus
        case .tertiarySystemGroupedBackgroundPerseus:
            return .tertiarySystemGroupedBackgroundPerseus

        case .perseusRed:
            return .perseusRed
        case .perseusOrange:
            return .perseusOrange
        case .perseusYellow:
            return .perseusYellow
        case .perseusGreen:
            return .perseusGreen
        case .perseusMint:
            return .perseusMint
        case .perseusTeal:
            return .perseusTeal
        case .perseusCyan:
            return .perseusCyan
        case .perseusBlue:
            return .perseusBlue
        case .perseusIndigo:
            return .perseusIndigo
        case .perseusPurple:
            return .perseusPurple
        case .perseusPink:
            return .perseusPink
        case .perseusBrown:
            return .perseusBrown
        case .perseusGray:
            return .perseusGray
        case .perseusGray2:
            return .perseusGray2
        case .perseusGray3:
            return .perseusGray3
        case .perseusGray4:
            return .perseusGray4
        case .perseusGray5:
            return .perseusGray5
        case .perseusGray6:
            return .perseusGray6
        }
    }
}
