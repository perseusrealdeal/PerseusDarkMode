//
//  DarkMode.swift
//  PerseusDarkMode
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

#if !os(macOS)
import UIKit
#endif

/// Represents Dark Mode and contains the app's appearance style.
///
/// - KVO technique can be used to be notified on the app's appearance style changed event.
/// - Use StyleObservable varible to create an observer.
public class DarkMode: NSObject {

    // MARK: - The App's current Appearance Style

    /// The app's current appearance style.
    public var Style: AppearanceStyle { _style }

    // MARK: - Observable Appearance Style Value (Using Key-Value Observing)

    /// Shows the same value of Style but observable.
    ///
    /// Takes place because swift doesn't support observing enums.
    @objc public dynamic var StyleObservable: Int = DARK_MODE_STYLE_DEFAULT.rawValue

    // MARK: - System's Appearance Style

    /// The app's current system appearance style.
    public var SystemStyle: SystemStyle {
        if #available(iOS 13.0, *) {
            guard let keyWindow = UIApplication.shared.keyWindow else { return .unspecified }

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
        } else {
            return .unspecified
        }
    }

    internal var _style: AppearanceStyle = DARK_MODE_STYLE_DEFAULT {
        didSet { StyleObservable = Style.rawValue }
    }
}

// MARK: - Protocols used for unit testing

public protocol DarkModeProtocol {
    var Style: AppearanceStyle { get }
    var SystemStyle: SystemStyle { get }

    dynamic var StyleObservable: Int { get }
}

extension DarkMode: DarkModeProtocol { }
