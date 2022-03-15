//
// SetupByDefault.swift
// PerseusDarkMode
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

public extension UIResponder { var DarkMode: DarkModeProtocol { AppearanceService.shared } }

public class UIWindowAdaptable: UIWindow
{
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)
    {
        guard #available(iOS 13.0, *) else { return }
        
        AppearanceService.overrideUserInterfaceStyleIfNeeded()
        
        guard let previousSystemStyle = previousTraitCollection?.userInterfaceStyle,
              previousSystemStyle.rawValue != DarkMode.SystemStyle.rawValue
        else { return }
        
        AppearanceService.makeUp()
    }
}

// Local helpers

extension UserDefaults
{
    public func valueExists(forKey key: String) -> Bool
    {
        return object(forKey: key) != nil
    }
}
