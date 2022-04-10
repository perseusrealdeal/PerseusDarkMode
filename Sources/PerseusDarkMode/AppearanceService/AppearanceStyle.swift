//
// AppearanceStyle.swift
// PerseusDarkMode
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

public enum AppearanceStyle: Int, CustomStringConvertible
{
    case light = 0
    case dark = 1
    
    public var description: String
    {
        switch self
        {
        case .light:
            return ".light"
        case .dark:
            return ".dark"
        }
    }
}

public enum SystemStyle: Int, CustomStringConvertible
{
    case unspecified = 0
    case light = 1
    case dark = 2
    
    public var description: String
    {
        switch self
        {
        case .unspecified:
            return ".unspecified"
        case .light:
            return ".light"
        case .dark:
            return ".dark"
        }
    }
}
