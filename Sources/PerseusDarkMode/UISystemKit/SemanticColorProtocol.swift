//
//  SemanticColorProtocol.swift
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

// MARK: - Semantic Colors Requirements

public protocol SemanticColorProtocol {

// MARK: - FOREGROUND CONTENT

    // MARK: - Label Colors

    /// Label.
    ///
    /// - Light: 0, 0, 0
    /// - Dark: 255, 255, 255
    static var labelPerseus: Color { get }

    /// Secondary label.
    ///
    /// - Light: 60, 60, 67, 0.6
    /// - Dark: 235, 235, 245, 0.6
    static var secondaryLabelPerseus: Color { get }

    /// Tertiary label.
    ///
    /// - Light: 60, 60, 67, 0.3
    /// - Dark: 235, 235, 245, 0.3
    static var tertiaryLabelPerseus: Color { get }

    /// Quaternary label.
    ///
    /// - Light: 60, 60, 67, 0.18
    /// - Dark: 235, 235, 245, 0.16
    static var quaternaryLabelPerseus: Color { get }

    // MARK: - Text Colors

    /// Placeholder text.
    ///
    /// - Light: 60, 60, 67, 0.3
    /// - Dark: 235, 235, 245, 0.3
    static var placeholderTextPerseus: Color { get }

    // MARK: - Separator Colors

    /// Separator.
    ///
    /// - Light: 60, 60, 67, 0.29
    /// - Dark: 84, 84, 88, 0.6
    static var separatorPerseus: Color { get }

    /// Opaque separator.
    ///
    /// - Light: 198, 198, 200
    /// - Dark: 56, 56, 58
    static var opaqueSeparatorPerseus: Color { get }

    // MARK: - Link Color

    /// Link.
    ///
    /// - Light: 0, 122, 255
    /// - Dark: 9, 132, 255
    static var linkPerseus: Color { get }

    // MARK: - Fill Colors

    /// System fill.
    ///
    /// - Light: 120, 120, 128, 0.2
    /// - Dark: 120, 120, 128, 0.36
    static var systemFillPerseus: Color { get }

    /// Secondary system fill.
    ///
    /// - Light: 120, 120, 128, 0.16
    /// - Dark: 120, 120, 128, 0.32
    static var secondarySystemFillPerseus: Color { get }

    /// Tertiary system fill.
    ///
    /// - Light: 118, 118, 128, 0.12
    /// - Dark: 118, 118, 128, 0.24
    static var tertiarySystemFillPerseus: Color { get }

    /// Quaternary system fill.
    ///
    /// - Light: 116, 116, 128, 0.08
    /// - Dark: 118, 118, 128, 0.18
    static var quaternarySystemFillPerseus: Color { get }

// MARK: - BACKGROUND CONTENT

    // MARK: - Standard

    /// System background.
    ///
    /// - Light: 255, 255, 255
    /// - Dark: 28, 28, 30
    static var systemBackgroundPerseus: Color { get }

    /// Secondary system background.
    ///
    /// - Light: 242, 242, 247
    /// - Dark: 44, 44, 46
    static var secondarySystemBackgroundPerseus: Color { get }

    /// Tertiary system background.
    ///
    /// - Light: 255, 255, 255
    /// - Dark: 58, 58, 60
    static var tertiarySystemBackgroundPerseus: Color { get }

    // MARK: - Grouped

    /// System grouped background.
    ///
    /// - Light: 242, 242, 247
    /// - Dark: 28, 28, 30
    static var systemGroupedBackgroundPerseus: Color { get }

    /// Secondary system grouped background.
    ///
    /// - Light: 255, 255, 255
    /// - Dark: 44, 44, 46
    static var secondarySystemGroupedBackgroundPerseus: Color { get }

    /// Tertiary system grouped background.
    ///
    /// - Light: 242, 242, 247
    /// - Dark: 58, 58, 60
    static var tertiarySystemGroupedBackgroundPerseus: Color { get }
}
