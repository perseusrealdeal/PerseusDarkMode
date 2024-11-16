//
//  SemanticColors.swift
//  PerseusDarkMode
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

// MARK: - Semantic Colors Offer

extension Color: SemanticColorProtocol {

    /// .label
    public static var labelPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(0, 0, 0) : rgba255(255, 255, 255)
    }

    /// .secondaryLabel
    public static var secondaryLabelPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(60, 60, 67, 0.6) : rgba255(235, 235, 245, 0.6)
    }

    /// .tertiaryLabel
    public static var tertiaryLabelPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(60, 60, 67, 0.3) : rgba255(235, 235, 245, 0.3)
    }

    /// .quaternaryLabel
    public static var quaternaryLabelPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(60, 60, 67, 0.18) : rgba255(235, 235, 245, 0.16)
    }

    /// .placeholderText
    public static var placeholderTextPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(60, 60, 67, 0.3) : rgba255(235, 235, 245, 0.3)
    }

    /// .separator
    public static var separatorPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(60, 60, 67, 0.29) : rgba255(84, 84, 88, 0.6)
    }

    /// .opaqueSeparator
    public static var opaqueSeparatorPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(198, 198, 200) : rgba255(56, 56, 58)
    }

    /// .link
    public static var linkPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(0, 122, 255) : rgba255(9, 132, 255)
    }

    /// .systemFill
    public static var systemFillPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(120, 120, 128, 0.2) : rgba255(120, 120, 128, 0.36)
    }

    /// .secondarySystemFill
    public static var secondarySystemFillPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(120, 120, 128, 0.16) : rgba255(120, 120, 128, 0.32)
    }

    /// .tertiarySystemFill
    public static var tertiarySystemFillPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(118, 118, 128, 0.12) : rgba255(118, 118, 128, 0.24)
    }

    /// .quaternarySystemFill
    public static var quaternarySystemFillPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(116, 116, 128, 0.08) : rgba255(118, 118, 128, 0.18)
    }

    /// .systemBackground
    public static var systemBackgroundPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(255, 255, 255) : rgba255(28, 28, 30)
    }

    /// .secondarySystemBackground
    public static var secondarySystemBackgroundPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(242, 242, 247) : rgba255(44, 44, 46)
    }

    /// .tertiarySystemBackground
    public static var tertiarySystemBackgroundPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(255, 255, 255) : rgba255(58, 58, 60)
    }

    /// .systemGroupedBackground
    public static var systemGroupedBackgroundPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(242, 242, 247) : rgba255(28, 28, 30)
    }

    /// .secondarySystemGroupedBackground
    public static var secondarySystemGroupedBackgroundPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(255, 255, 255) : rgba255(44, 44, 46)
    }

    /// .tertiarySystemGroupedBackground
    public static var tertiarySystemGroupedBackgroundPerseus: Color {
        return AppearanceService.shared.style == .light ?
            rgba255(242, 242, 247) : rgba255(58, 58, 60)
    }
}
