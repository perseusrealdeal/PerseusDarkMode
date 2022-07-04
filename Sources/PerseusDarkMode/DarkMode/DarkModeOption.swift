//
//  DarkModeOption.swift
//  PerseusDarkMode
//
//  Created by Mikhail Zhigulin in 2022.
//
//  Copyright (c) 2022 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

import Foundation

/// Represents a list of possible values for Dark Mode option.
///
/// - AUTO means the choice is made by System.
/// - ON means the app's appearance style should be Dark at any case.
/// - OFF means the app's appearance style should be Light at any case.
public enum DarkModeOption: Int, CustomStringConvertible {

    case auto = 0
    case on   = 1
    case off  = 2

    /// Textual representation of the current value of the option.
    public var description: String {
        switch self {
        case .auto:
            return ".auto"
        case .on:
            return ".on"
        case .off:
            return ".off"
        }
    }
}
