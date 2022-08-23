//
//  AppearanceStyle.swift
//  PerseusDarkMode
//
//  Created by Mikhail Zhigulin in 2022.
//
//  Copyright (c) 2022 Mikhail Zhigulin of Novosibirsk.
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

/// Represents appearance style.
public enum AppearanceStyle: Int, CustomStringConvertible {

    case light = 0
    case dark  = 1

    /// Textual represantation.
    public var description: String {
        switch self {
        case .light:
            return ".light"
        case .dark:
            return ".dark"
        }
    }
}

/// Represents system appearance style.
///
/// Used to bring System Style to early iOS releases.
public enum SystemStyle: Int, CustomStringConvertible {

    case unspecified = 0
    case light       = 1
    case dark        = 2

    /// Textual represantation.
    public var description: String {
        switch self {
        case .unspecified:
            return ".unspecified"
        case .light:
            return ".light"
        case .dark:
            return ".dark"
        }
    }
}
