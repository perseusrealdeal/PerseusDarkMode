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

/// Represents a quite light implementation of a dynamic image idea that depends on the app's appearance style.
///
/// Use Interface Builder to set images up for both light and dark styles.
public class DarkModeImageView: UIImageView {
    /// The way to set image up for light style via Interface Builder.
    @IBInspectable
    var imageLight: UIImage? {
        didSet {
            light = imageLight
            image = AppearanceService.shared.Style == .light ? light : dark
        }
    }

    /// The way to set image up for dark style via Interface Builder.
    @IBInspectable
    var imageDark : UIImage? {
        didSet {
            dark = imageDark
            image = AppearanceService.shared.Style == .light ? light : dark
        }
    }

    /// Observer for the app's appearance style changes.
    private(set) var darkModeObserver: DarkModeObserver?

    /// When the app's appearance style is Light.
    private(set) var light: UIImage?
    /// When the app's appearance style is Dark.
    private(set) var dark: UIImage?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    /// Configures the view.
    private func configure() {
        darkModeObserver = DarkModeObserver { style in
            self.image = style == .light ? self.light : self.dark
        }
    }

    /// Sets images for both light and dark styles.
    /// - Parameters:
    ///   - light: Image for light style.
    ///   - dark: Image for dark style.
    public func configure(_ light: UIImage?, _ dark: UIImage?) {
        self.light = light
        self.dark = dark

        darkModeObserver?.action = { style in
            self.image = style == .light ? self.light : self.dark
        }

        image = AppearanceService.shared.Style == .light ? self.light : self.dark
    }
}
