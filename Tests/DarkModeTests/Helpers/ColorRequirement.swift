//
// ColorRequirement.swift
// DarkModeTests
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

import UIKit
@testable import AdaptedSystemUI

enum ColorRequirement
{
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
    case tertiarySystemFilll
    case quaternarySystemFill
    
    case systemBackground
    case secondarySystemBackground
    case tertiarySystemBackground
    
    case systemGroupedBackground
    case secondarySystemGroupedBackground
    case tertiarySystemGroupedBackground
    
    var color: UIColor
    {
        switch self
        {
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
        case .tertiarySystemFilll:
            return .tertiarySystemFilll_Adapted
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
        }
    }
}
