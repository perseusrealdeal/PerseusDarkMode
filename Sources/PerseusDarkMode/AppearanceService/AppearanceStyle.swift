//
// AppearanceStyle.swift
// PerseusDarkMode
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

import Foundation

public enum AppearanceStyle: Int, CustomStringConvertible
{
    case light = 0
    case dark = 1
    
    public var description: String
    {
        switch self
        {
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        }
    }
}

public enum SystemStyle: Int
{
    case unspecified = 0
    case light = 1
    case dark = 2
}
