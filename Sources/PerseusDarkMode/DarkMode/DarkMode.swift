//
//  DarkMode.swift
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

/// Represents Dark Mode and contains the app's appearance style.
///
/// - KVO technique can be used to be notified on the app's appearance style changed event.
/// - Use StyleObservable varible to create an observer.
public class DarkMode: NSObject {

    // MARK: - The App's current Appearance Style

    /// The app's current appearance style.
    public var style: AppearanceStyle { return hidden_style }

    // MARK: - Observable Appearance Style Value (Using Key-Value Observing)

    /// Shows the same value of Style but observable.
    ///
    /// Takes place because swift doesn't support observing enums.
    @objc public dynamic var styleObservable: Int = DARK_MODE_STYLE_DEFAULT.rawValue

    // MARK: - System's Appearance Style

    /// The app's current system appearance style.
    public var systemStyle: SystemStyle {
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
            if let isDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle"),
               isDark == "Dark" {
                return .dark
            } else {
                return .light
            }
            */

            let effectiveDark = NSApp.windows.first?.effectiveAppearance.bestMatch(
                from: [.darkAqua, .vibrantDark])

            return [.darkAqua, .vibrantDark].contains(effectiveDark) ? .dark : .light
#endif
        } else {
            return .unspecified
        }
    }

    internal var hidden_style: AppearanceStyle = DARK_MODE_STYLE_DEFAULT {
        didSet { styleObservable = style.rawValue }
    }
}

// MARK: - Protocols used for unit testing

public protocol DarkModeProtocol {
    var style: AppearanceStyle { get }
    var systemStyle: SystemStyle { get }
    var styleObservable: Int { get }
}

extension DarkMode: DarkModeProtocol { }
