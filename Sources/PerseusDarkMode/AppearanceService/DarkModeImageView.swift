//
//  DarkModeImageView.swift
//  PerseusDarkMode
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

#if !os(macOS)
import UIKit
#endif

/// Represents a quite light release of a dynamic image idea that depends on the app's appearance style.
///
/// Use Interface Builder to set images up for both light and dark styles.
public class DarkModeImageView: UIImageView
{
    /// The way to set image up for light style via Interface Builder.
    @IBInspectable
    var imageLight: UIImage?
    {
        didSet
        {
            light = imageLight
            image = AppearanceService.shared.Style == .light ? light : dark
        }
    }
    
    /// The way to set image up for dark style via Interface Builder.
    @IBInspectable
    var imageDark : UIImage?
    {
        didSet
        {
            dark = imageDark
            image = AppearanceService.shared.Style == .light ? light : dark
        }
    }
    
    /// Observer to trigger view image if the app's appearance style changed.
    private(set) var darkModeObserver: DarkModeObserver?
    
    /// Image used if the app's appearance style is Light.
    private(set) var light: UIImage?
    /// Image used if the app's appearance style is Dark.
    private(set) var dark: UIImage?
    
    /// Called if not represented with Interface Builder.
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        configure()
    }
    
    /// Called if represeinted with Interface Builder.
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        configure()
    }
    
    /// Called in initialization.
    private func configure()
    {
        darkModeObserver = DarkModeObserver()
        {
            style in  self.image = style == .light ? self.light : self.dark
        }
    }
    
    /// Setting images for changing up.
    /// - Parameters:
    ///   - light: Image for Light Style.
    ///   - dark: Image for Dark Style.
    public func configure(_ light: UIImage?, _ dark: UIImage?)
    {
        self.light = light
        self.dark = dark
        
        darkModeObserver?.action =
        {
            style in  self.image = style == .light ? self.light : self.dark
        }
        
        image = AppearanceService.shared.Style == .light ? self.light : self.dark
    }
}
