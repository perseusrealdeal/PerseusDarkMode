//
// DarkModeImageView.swift
// PerseusDarkMode
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

import UIKit

public class DarkModeImageView: UIImageView
{
    private(set) var darkModeObserver = DarkModeObserver(AppearanceService.shared)
    
    private(set) var imageLight: UIImage?
    private(set) var imageDark : UIImage?
    
    public func setUp(_ light: UIImage?, _ dark: UIImage?)
    {
        imageLight = light
        imageDark = dark
        
        image = AppearanceService.shared.Style == .light ? light : dark
        darkModeObserver.action = { style in  self.image = style == .light ? light : dark }
    }
}

