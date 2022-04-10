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
        super.traitCollectionDidChange(previousTraitCollection)
        
        if AppearanceService._changeManually { return }
        guard #available(iOS 13.0, *) else { return }
        
        guard let previousSystemStyle = previousTraitCollection?.userInterfaceStyle,
              previousSystemStyle.rawValue != DarkMode.SystemStyle.rawValue
        else { return }
        
        AppearanceService.systemCalledMakeUp()
    }
}
