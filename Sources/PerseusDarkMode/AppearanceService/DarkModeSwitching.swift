//
//  DarkModeSwitching.swift
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

// Dark Mode option key used in Settings bundle.
public let DARK_MODE_SETTINGS_KEY = "dark_mode_preference"

public func changeDarkModeManually(_ userChoice: DarkModeOption) {
    // Change Dark Mode value in settings bundle
    UserDefaults.standard.setValue(userChoice.rawValue, forKey: DARK_MODE_SETTINGS_KEY)

    // Change Dark Mode value in Perseus Dark Mode library
    DarkModeAgent.DarkModeUserChoice = userChoice

    // Update appearance in accoring with changed Dark Mode Style
    DarkModeAgent.makeUp()
}

public func isDarkModeSettingsChanged() -> DarkModeOption? {
    // Load enum int value from settings
    let option = UserDefaults.standard.valueExists(forKey: DARK_MODE_SETTINGS_KEY) ?
        UserDefaults.standard.integer(forKey: DARK_MODE_SETTINGS_KEY) : -1

    // Try to cast int value to enum
    guard option != -1, let settingsDarkMode = DarkModeOption.init(rawValue: option)
        else { return nil } // Should throw exception if init gives nil

    // Report change
    return settingsDarkMode != DarkModeAgent.DarkModeUserChoice ? settingsDarkMode : nil
}
