//
//  DarkModeRequired.swift
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

extension DarkModeAgent {

    public static func currentSystemStyle() -> SystemStyle {
        if #available(iOS 13.0, macOS 10.14, *) {
#if os(iOS)
            guard let keyWindow = UIWindow.key else { return .unspecified }

            switch keyWindow.traitCollection.userInterfaceStyle {
            case .unspecified:
                return .unspecified
            case .light:
                return .light
            case .dark:
                return .dark

            @unknown default:
                return .unspecified
            }
#elseif os(macOS)
            /*
            if force == .os {

                let isDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle")
                let current: SystemStyle = isDark == "Dark" ? .dark : .light

                return current
            }

            if #available(macOS 11.0, *) {

                let current = NSAppearance.currentDrawing()
                let effectiveDark = current.bestMatch(from: [.darkAqua, .vibrantDark])

                return [.darkAqua, .vibrantDark].contains(effectiveDark) ? .dark : .light
            }

            // Fallback on earlier versions Mojave 10.14, Catalina 10.15.

            let effectiveDark = NSApp.windows.first?.effectiveAppearance.bestMatch(
                from: [.darkAqua, .vibrantDark])

            return [.darkAqua, .vibrantDark].contains(effectiveDark) ? .dark : .light
            */

            let isDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle")
            let current: SystemStyle = isDark == "Dark" ? .dark : .light

            return current
#endif
        } else {
            return .unspecified // HighSierra 10.13, earlier iOS 12.0 and so on.
        }
    }

    public static func recalculateStyleIfNeeded(_ current: SystemStyle) {
        let requiredStyle = calcRequired(DarkModeUserChoice, current)
        if shared.hidden_style != requiredStyle { shared.hidden_style = requiredStyle }
    }

    // MARK: - Calculating Dark Mode Required

    /// Calculates the current required appearance style of the app.
    ///
    /// Dark Mode decision-making:
    ///
    ///                  | User
    ///     -------------+-----------------------
    ///     System       | auto    | on   | off
    ///     -------------+---------+------+------
    ///     .unspecified | default | dark | light
    ///     .light       | light   | dark | light
    ///     .dark        | dark    | dark | light
    ///
    public static func calcRequired(_ user: DarkModeOption,
                                    _ system: SystemStyle) -> AppearanceStyle {

        if (system == .unspecified) && (user == .auto) { return DARK_MODE_DEFAULT }
        if (system == .unspecified) && (user == .on) { return .dark }
        if (system == .unspecified) && (user == .off) { return .light }

        if (system == .light) && (user == .auto) { return .light }
        if (system == .light) && (user == .on) { return .dark }
        if (system == .light) && (user == .off) { return .light }

        if (system == .dark) && (user == .auto) { return .dark }
        if (system == .dark) && (user == .on) { return .dark }
        if (system == .dark) && (user == .off) { return .light }

        // Output default value if somethings goes out of the decision table

        return DARK_MODE_DEFAULT
    }
}
