//
//  DarkModeDecision.swift
//  PerseusDarkMode
//
//  Created by Mikhail Zhigulin in 2022.
//
//  Copyright (c) 2022 Mikhail Zhigulin of Novosibirsk.
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

#if !os(macOS)
import UIKit
#endif

/// Makes a calculation of the app's appearance style.
public class DarkModeDecision {

    private init() { }

    // MARK: - Calculating Dark Mode decision

    /// Calculates the current appearance style of the app.
    ///
    /// Dark Mode decision-making:
    ///
    ///                    DarkModeOption
    ///     SystemStyle  | auto    | on   | off
    ///     -------------+---------+------+------
    ///     .unspecified | default | dark | light
    ///     .light       | light   | dark | light
    ///     .dark        | dark    | dark | light
    ///
    public class func calculate(_ userChoice: DarkModeOption,
                                _ systemStyle: SystemStyle) -> AppearanceStyle {
        // Calculate outputs

        if (systemStyle == .unspecified) && (userChoice == .auto) {
            return DARK_MODE_STYLE_DEFAULT
        }
        if (systemStyle == .unspecified) && (userChoice == .on) { return .dark }
        if (systemStyle == .unspecified) && (userChoice == .off) { return .light }

        if (systemStyle == .light) && (userChoice == .auto) { return .light }
        if (systemStyle == .light) && (userChoice == .on) { return .dark }
        if (systemStyle == .light) && (userChoice == .off) { return .light }

        if (systemStyle == .dark) && (userChoice == .auto) { return .dark }
        if (systemStyle == .dark) && (userChoice == .on) { return .dark }
        if (systemStyle == .dark) && (userChoice == .off) { return .light }

        // Output default value if somethings goes out of the decision table

        return DARK_MODE_STYLE_DEFAULT
    }
}
