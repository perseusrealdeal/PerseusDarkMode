//
//  ColorRequirement.swift
//  DarkModeTests
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

#if !os(macOS)
import UIKit
#endif

@testable import AdaptedSystemUI

enum ColorRequirement {

    case label
    case secondaryLabel
    case tertiaryLabel
    case quaternaryLabel
    case placeholderText
    case separator
    case opaqueSeparator
    case link

    case systemFill
    case secondarySystemFill
    case tertiarySystemFill
    case quaternarySystemFill

    case systemBackground
    case secondarySystemBackground
    case tertiarySystemBackground

    case systemGroupedBackground
    case secondarySystemGroupedBackground
    case tertiarySystemGroupedBackground

    case systemRed
    case systemOrange
    case systemYellow
    case systemGreen
    case systemMint
    case systemTeal
    case systemCyan
    case systemBlue
    case systemIndigo
    case systemPurple
    case systemPink
    case systemBrown

    case systemGray
    case systemGray2
    case systemGray3
    case systemGray4
    case systemGray5
    case systemGray6

    var color: UIColor {
        switch self {
        case .label:
            return .label_Adapted
        case .secondaryLabel:
            return .secondaryLabel_Adapted
        case .tertiaryLabel:
            return .tertiaryLabel_Adapted
        case .quaternaryLabel:
            return .quaternaryLabel_Adapted
        case .placeholderText:
            return .placeholderText_Adapted
        case .separator:
            return .separator_Adapted
        case .opaqueSeparator:
            return .opaqueSeparator_Adapted
        case .link:
            return .link_Adapted

        case .systemFill:
            return .systemFill_Adapted
        case .secondarySystemFill:
            return .secondarySystemFill_Adapted
        case .tertiarySystemFill:
            return .tertiarySystemFill_Adapted
        case .quaternarySystemFill:
            return .quaternarySystemFill_Adapted

        case .systemBackground:
            return .systemBackground_Adapted
        case .secondarySystemBackground:
            return .secondarySystemBackground_Adapted
        case .tertiarySystemBackground:
            return .tertiarySystemBackground_Adapted

        case .systemGroupedBackground:
            return .systemGroupedBackground_Adapted
        case .secondarySystemGroupedBackground:
            return .secondarySystemGroupedBackground_Adapted
        case .tertiarySystemGroupedBackground:
            return .tertiarySystemGroupedBackground_Adapted

        case .systemRed:
            return .systemRed_Adapted
        case .systemOrange:
            return .systemOrange_Adapted
        case .systemYellow:
            return .systemYellow_Adapted
        case .systemGreen:
            return .systemGreen_Adapted
        case .systemMint:
            return .systemMint_Adapted
        case .systemTeal:
            return .systemTeal_Adapted
        case .systemCyan:
            return .systemCyan_Adapted
        case .systemBlue:
            return .systemBlue_Adapted
        case .systemIndigo:
            return .systemIndigo_Adapted
        case .systemPurple:
            return .systemPurple_Adapted
        case .systemPink:
            return .systemPink_Adapted
        case .systemBrown:
            return .systemBrown_Adapted

        case .systemGray:
            return .systemGray_Adapted
        case .systemGray2:
            return .systemGray2_Adapted
        case .systemGray3:
            return .systemGray3_Adapted
        case .systemGray4:
            return .systemGray4_Adapted
        case .systemGray5:
            return .systemGray5_Adapted
        case .systemGray6:
            return .systemGray6_Adapted
        }
    }
}
