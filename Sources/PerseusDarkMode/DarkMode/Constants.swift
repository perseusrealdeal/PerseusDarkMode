//
//  Constants.swift
//  PerseusDarkMode
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import Foundation

/// UserDefaults Key for AppearanceService.DarkModeUserChoice variable.
public let DARK_MODE_USER_CHOICE_KEY = "DarkModeUserChoiceOptionKey"

/// Default value for AppearanceService.DarkModeUserChoice variable.
public let DARK_MODE_USER_CHOICE_DEFAULT = DarkModeOption.auto

/// Default valur for AppearanceService.shared.Style.
public let DARK_MODE_STYLE_DEFAULT = AppearanceStyle.light

/// Name of DarkMode.StyleObservable variable used in KVO
public let OBSERVERED_VARIABLE_NAME = "styleObservable"
