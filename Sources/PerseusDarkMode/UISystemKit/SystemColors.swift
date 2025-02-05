//
//  SystemColors.swift
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

// MARK: - System Colors Offer

extension Color: SystemColorProtocol {

    /// .systemRed
    public static var perseusRed: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(255, 59, 48) : rgba255(255, 69, 58)
    }

    /// .systemOrange
    public static var perseusOrange: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(255, 149, 0) : rgba255(255, 159, 10)
    }

    /// .systemYellow
    public static var perseusYellow: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(255, 204, 0) : rgba255(255, 214, 10)
    }

    /// .systemGreen
    public static var perseusGreen: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(52, 199, 89) : rgba255(48, 209, 88)
    }

    /// .systemMint
    public static var perseusMint: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(0, 199, 190) : rgba255(102, 212, 207)
    }

    /// .systemTeal
    public static var perseusTeal: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(48, 176, 199) : rgba255(64, 200, 224)
    }

    /// .systemCyan
    public static var perseusCyan: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(50, 173, 230) : rgba255(100, 210, 255)
    }

    /// .systemBlue
    public static var perseusBlue: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(0, 122, 255) : rgba255(10, 132, 255)
    }

    /// .systemIndigo
    public static var perseusIndigo: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(88, 86, 214) : rgba255(94, 92, 230)
    }

    /// .systemPurple
    public static var perseusPurple: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(175, 82, 222) : rgba255(191, 90, 242)
    }

    /// .systemPink
    public static var perseusPink: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(255, 45, 85) : rgba255(255, 55, 95)
    }

    /// .systemBrown
    public static var perseusBrown: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(162, 132, 94) : rgba255(172, 142, 104)
    }

    /// .systemGray
    public static var perseusGray: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(142, 142, 147) : rgba255(142, 142, 147)
    }

    /// .systemGray2
    public static var perseusGray2: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(174, 174, 178) : rgba255(99, 99, 102)
    }

    /// .systemGray3
    public static var perseusGray3: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(199, 199, 204) : rgba255(72, 72, 74)
    }

    /// .systemGray4
    public static var perseusGray4: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(209, 209, 214) : rgba255(58, 58, 60)
    }

    /// .systemGray5
    public static var perseusGray5: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(229, 229, 234) : rgba255(44, 44, 46)
    }

    /// .systemGray6
    public static var perseusGray6: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(242, 242, 247) : rgba255(28, 28, 30)
    }
}
