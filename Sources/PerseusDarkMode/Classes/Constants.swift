//
//  Constants.swift
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

import Foundation

#if canImport(Cocoa)
import Cocoa
#endif

/// UserDefaults Key for AppearanceService.DarkModeUserChoice variable.
public let DARK_MODE_USER_CHOICE_KEY = "DarkModeUserChoiceOptionKey"

/// Default value for AppearanceService.DarkModeUserChoice variable.
public let DARK_MODE_USER_CHOICE_DEFAULT = DarkModeOption.auto

/// Default valur for AppearanceService.shared.Style.
public let DARK_MODE_DEFAULT = AppearanceStyle.light

/// Name of DarkMode.StyleObservable variable used in KVO
public let OBSERVERED_VARIABLE_NAME = "styleObservable"

#if os(macOS)
public var DARK_OS_DEFAULT: NSAppearance.Name {
    if #available(macOS 10.14, *) {
        return .darkAqua
    }
    return .vibrantDark
}
public let LIGHT_OS_DEFAULT: NSAppearance.Name = .aqua
#endif
