//
// SetupByDefault.swift
// PerseusDarkMode
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

public extension UIViewController
{
    @objc dynamic var DarkMode: DarkMode { AppearanceService.shared }
}

public extension UIView
{
    @objc dynamic var DarkMode: DarkMode { AppearanceService.shared }
}

public class UIWindowAdaptable: UIWindow
{
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)
    {
        guard
            #available(iOS 13.0, *),
            let previousSystemStyle = previousTraitCollection?.userInterfaceStyle,
            previousSystemStyle.rawValue != DarkMode.SystemStyle.rawValue
        else { return }
        
        let userChoice = AppearanceService.DarkModeUserChoice
        let systemStyle = AppearanceService.shared.SystemStyle
        
        AppearanceService.shared._style = DarkModeDecision.calculate(userChoice, systemStyle)
        
        AppearanceService.makeUp()
    }
}

// Local helpers

extension UserDefaults
{
    func valueExists(forKey key: String) -> Bool
    {
        return object(forKey: key) != nil
    }
}
