//
//  SystemColorProtocol.swift
//  AdaptedSystemUI
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

#if !os(macOS)
import UIKit
#endif

/// Represents system colors requirements.
public protocol SystemColorProtocol {

    // MARK: - SYSTEM COLORS

    /// Red.
    ///
    /// - Light: 255, 59, 48
    /// - Dark: 255, 69, 58
    static var systemRed_Adapted   : UIColor { get }

    /// Orange.
    ///
    /// - Light: 255, 149, 0
    /// - Dark: 255, 159, 10
    static var systemOrange_Adapted: UIColor { get }

    /// Yellow.
    ///
    /// - Light: 255, 204, 0
    /// - Dark: 255, 214, 10
    static var systemYellow_Adapted: UIColor { get }

    /// Green.
    ///
    /// - Light: 52, 199, 89
    /// - Dark: 48, 209, 88
    static var systemGreen_Adapted : UIColor { get }

    /// Mint.
    ///
    /// - Light: 0, 199, 190
    /// - Dark: 102, 212, 207
    static var systemMint_Adapted  : UIColor { get }

    /// Teal.
    ///
    /// - Light: 48, 176, 199
    /// - Dark: 64, 200, 224
    static var systemTeal_Adapted  : UIColor { get }

    /// Cyan.
    ///
    /// - Light: 50, 173, 230
    /// - Dark: 100, 210, 255
    static var systemCyan_Adapted  : UIColor { get }

    /// Blue.
    ///
    /// - Light: 0, 122, 255
    /// - Dark: 10, 132, 255
    static var systemBlue_Adapted  : UIColor { get }

    /// Indigo.
    ///
    /// - Light: 88, 86, 214
    /// - Dark: 94, 92, 230
    static var systemIndigo_Adapted: UIColor { get }

    /// Purple.
    ///
    /// - Light: 175, 82, 222
    /// - Dark: 191, 90, 242
    static var systemPurple_Adapted: UIColor { get }

    /// Pink.
    ///
    /// - Light: 255, 45, 85
    /// - Dark: 255, 55, 95
    static var systemPink_Adapted  : UIColor { get }

    /// Brown.
    ///
    /// - Light: 162, 132, 94
    /// - Dark: 172, 142, 104
    static var systemBrown_Adapted : UIColor { get }

    // MARK: - The group of system gray colors

    /// Gray.
    ///
    /// - Light: 142, 142, 147
    /// - Dark: 142, 142, 147
    static var systemGray_Adapted  : UIColor { get }

    /// Gray (2).
    ///
    /// - Light: 174, 174, 178
    /// - Dark: 99, 99, 102
    static var systemGray2_Adapted : UIColor { get }

    /// Gray (3).
    ///
    /// - Light: 199, 199, 204
    /// - Dark: 72, 72, 74
    static var systemGray3_Adapted : UIColor { get }

    /// Gray (4).
    ///
    /// - Light: 209, 209, 214
    /// - Dark: 58, 58, 60
    static var systemGray4_Adapted : UIColor { get }

    /// Gray (5).
    ///
    /// - Light: 229, 229, 234
    /// - Dark: 44, 44, 46
    static var systemGray5_Adapted : UIColor { get }

    /// Gray (6).
    ///
    /// - Light: 242, 242, 247
    /// - Dark: 28, 28, 30
    static var systemGray6_Adapted : UIColor { get }
}
