//
// DarkModeOption.swift
// PerseusDarkMode
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

import Foundation

public enum DarkModeOption: Int, CustomStringConvertible
{
    case auto = 0
    case on = 1
    case off = 2
    
    public var description: String
    {
        switch self
        {
        case .auto:
            return "Auto"
        case .on:
            return "On"
        case .off:
            return "Off"
        }
    }
}
