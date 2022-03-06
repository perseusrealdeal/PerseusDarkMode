//
// DarkMode.swift
// PerseusDarkMode
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

public class DarkMode
{
    // MARK: - Dark Mode Style
    
    public var Style             : AppearanceStyle
    {
        let userChoice = DarkModeUserChoice
        let systemStyle = DarkModeDecision.calculateSystemStyle()
        
        return DarkModeDecision.calculateActualStyle(userChoice, systemStyle)
    }
    
    public var isEnabled         : Bool = false { willSet { if newValue == false { return } } }
    
    // MARK: - Dark Mode Style saved in UserDafaults
    
    public var userDefaults      : UserDefaults?
    
    public var DarkModeUserChoice: DarkModeOption
    {
        get
        {
            guard let ud = userDefaults else { return DARK_MODE_USER_CHOICE_DEFAULT }
            
            // load enum int value
            
            let rawValue = ud.valueExists(forKey: DARK_MODE_USER_CHOICE_OPTION_KEY) ?
                ud.integer(forKey: DARK_MODE_USER_CHOICE_OPTION_KEY) :
                DARK_MODE_USER_CHOICE_DEFAULT.rawValue
            
            // try to cast int value to enum
            
            if let result = DarkModeOption.init(rawValue: rawValue) { return result }
            
            return DARK_MODE_USER_CHOICE_DEFAULT
        }
        set
        {
            guard let ud = userDefaults else { return }
            
            ud.setValue(newValue.rawValue, forKey: DARK_MODE_USER_CHOICE_OPTION_KEY)
        }
    }
}
