//
//  DarkModeImageView.swift
//  PerseusDarkMode
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//
// swiftlint:disable file_length
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

#if os(iOS)

@IBDesignable
public class DarkModeImageView: UIImageView {

    @IBInspectable
    public var imageLight: UIImage? {
        didSet {
            light = imageLight
            image = DarkMode.style == .light ? light : dark
        }
    }

    @IBInspectable
    public var imageDark: UIImage? {
        didSet {
            dark = imageDark
            image = DarkMode.style == .light ? light : dark
        }
    }

    private(set) var darkModeObserver: DarkModeObserver?

    private(set) var light: UIImage?
    private(set) var dark: UIImage?

    override init(frame: CGRect) {
        super.init(frame: frame)

        // log.message("[\(type(of: self))].\(#function)")

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // log.message("[\(type(of: self))].\(#function)")

        configure()
    }

    private func configure() {
        darkModeObserver = DarkModeObserver { style in
            self.image = style == .light ? self.light : self.dark
        }

        image = DarkMode.style == .light ? self.light : self.dark
    }

    public func configure(_ light: UIImage?, _ dark: UIImage?) {
        self.light = light
        self.dark = dark

        darkModeObserver?.action = { style in
            self.image = style == .light ? self.light : self.dark
        }

        image = DarkMode.style == .light ? self.light : self.dark
    }
}

#elseif os(macOS)

public enum ScaleImageViewMacOS: Int, CustomStringConvertible {

    case scaleNone                  = 0 // No scale at all
    case axesIndependently          = 1 // Aspect Fill
    case proportionallyUpOrDown     = 2 // Aspect Fit
    case proportionallyDown         = 3 // Center Top
    case proportionallyClipToBounds = 4 // Aspect Fill with cliping to ImageView bounds

    public var description: String {
        switch self {
        case .scaleNone:
            return "As is, no scaling."
        case .axesIndependently:
            return "Aspect Fill."
        case .proportionallyUpOrDown:
            return "Aspect Fit."
        case .proportionallyDown:
            return "Center Top."
        case .proportionallyClipToBounds:
            return "Aspect Fill cliped to bounds."
        }
    }

    public var value: NSImageScaling {
        switch self {
        case .scaleNone:
            return .scaleNone
        case .axesIndependently:
            return .scaleAxesIndependently
        case .proportionallyUpOrDown:
            return .scaleProportionallyUpOrDown
        case .proportionallyDown:
            return .scaleProportionallyDown
        case .proportionallyClipToBounds:
            return .scaleNone
        }
    }
}

@IBDesignable
public class DarkModeImageView: NSImageView {

    @IBInspectable
    public var imageLight: NSImage? {
        didSet {
            image = DarkMode.style == .light ? imageLight : imageDark
        }
    }

    @IBInspectable
    public var imageDark: NSImage? {
        didSet {
            image = DarkMode.style == .light ? imageLight : imageDark
        }
    }

    @IBInspectable
    public var aspectFillClipToBounds: Bool = false

    public var customScale: ScaleImageViewMacOS = .scaleNone {
        didSet {
            guard customScale != .proportionallyClipToBounds else {

                self.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                self.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

                self.aspectFillClipToBounds = true
                self.imageScaling = .scaleNone

                return
            }

            self.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
            self.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

            self.aspectFillClipToBounds = false
            self.imageScaling = customScale.value
        }
    }

    private(set) var darkModeObserver: DarkModeObserver?

    override public func awakeFromNib() {

        // log.message("[\(type(of: self))].\(#function)")

        guard aspectFillClipToBounds else { return }

        self.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        self.imageScaling = .scaleNone
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        // log.message("[\(type(of: self))].\(#function)")

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // log.message("[\(type(of: self))].\(#function)")

        configure()
    }

    public func configure(_ light: NSImage?, _ dark: NSImage?) {
        configure()

        self.imageLight = light
        self.imageDark = dark
    }

    private func configure() {
        darkModeObserver = DarkModeObserver { style in
            self.image = style == .light ? self.imageLight : self.imageDark
        }
    }

    override public func draw(_ dirtyRect: NSRect) {
        guard aspectFillClipToBounds, let image = self.image else {
            super.draw(dirtyRect)
            return
        }

        // Get variables

        let viewWidth = self.bounds.size.width
        let viewHeight = self.bounds.size.height

        let width = image.size.width
        let height = image.size.height

        // https://study.com/learn/lesson/what-is-aspect-ratio.html
        let imageViewRatio = viewWidth / viewHeight
        let imageRatio = width / height

        // Scale image of the ImageView with clipping to bounds

        image.size.width = imageRatio < imageViewRatio ? viewWidth : viewHeight * imageRatio
        image.size.height = imageRatio < imageViewRatio ? viewWidth / imageRatio : viewHeight

        super.draw(dirtyRect)
    }
}

#endif
