//
//  SystemColorProtocol.swift
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

// MARK: - System Colors Requirements

public protocol SystemColorProtocol {

    /// Red is .systemRed
    ///
    /// - Light: 255, 59, 48
    /// - Dark: 255, 69, 58
    static var perseusRed: Color { get }

    /// Orange is .systemOrange
    ///
    /// - Light: 255, 149, 0
    /// - Dark: 255, 159, 10
    static var perseusOrange: Color { get }

    /// Yellow is .systemYellow
    ///
    /// - Light: 255, 204, 0
    /// - Dark: 255, 214, 10
    static var perseusYellow: Color { get }

    /// Green is .systemGreenGreen
    ///
    /// - Light: 52, 199, 89
    /// - Dark: 48, 209, 88
    static var perseusGreen: Color { get }

    /// Mint is .systemMint
    ///
    /// - Light: 0, 199, 190
    /// - Dark: 102, 212, 207
    static var perseusMint: Color { get }

    /// Teal is .systemTeal
    ///
    /// - Light: 48, 176, 199
    /// - Dark: 64, 200, 224
    static var perseusTeal: Color { get }

    /// Cyan is .systemCyan
    ///
    /// - Light: 50, 173, 230
    /// - Dark: 100, 210, 255
    static var perseusCyan: Color { get }

    /// Blue is .systemBlue
    ///
    /// - Light: 0, 122, 255
    /// - Dark: 10, 132, 255
    static var perseusBlue: Color { get }

    /// Indigo is .systemIndigo
    ///
    /// - Light: 88, 86, 214
    /// - Dark: 94, 92, 230
    static var perseusIndigo: Color { get }

    /// Purple is .systemPurple
    ///
    /// - Light: 175, 82, 222
    /// - Dark: 191, 90, 242
    static var perseusPurple: Color { get }

    /// Pink is .systemPink
    ///
    /// - Light: 255, 45, 85
    /// - Dark: 255, 55, 95
    static var perseusPink: Color { get }

    /// Brown is .systemBrown
    ///
    /// - Light: 162, 132, 94
    /// - Dark: 172, 142, 104
    static var perseusBrown: Color { get }

// MARK: - System Gray Colors

    /// Gray is .systemGray
    ///
    /// - Light: 142, 142, 147
    /// - Dark: 142, 142, 147
    static var perseusGray: Color { get }

    /// Gray (2) is .systemGray62
    ///
    /// - Light: 174, 174, 178
    /// - Dark: 99, 99, 102
    static var perseusGray2: Color { get }

    /// Gray (3) is .systemGray3
    ///
    /// - Light: 199, 199, 204
    /// - Dark: 72, 72, 74
    static var perseusGray3: Color { get }

    /// Gray (4) is .systemGray4
    ///
    /// - Light: 209, 209, 214
    /// - Dark: 58, 58, 60
    static var perseusGray4: Color { get }

    /// Gray (5) is .systemGray5
    ///
    /// - Light: 229, 229, 234
    /// - Dark: 44, 44, 46
    static var perseusGray5: Color { get }

    /// Gray (6) is .systemGray6
    ///
    /// - Light: 242, 242, 247
    /// - Dark: 28, 28, 30
    static var perseusGray6: Color { get }
}
