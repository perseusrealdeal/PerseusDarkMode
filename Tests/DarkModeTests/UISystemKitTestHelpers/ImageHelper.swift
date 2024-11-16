//
//  ImageHelper.swift
//  PerseusDarkModeTests
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

#if os(iOS)
// public typealias View = UIView
public typealias Image = UIImage
#elseif os(macOS)
// public typealias View = NSView
public typealias Image = NSImage
#endif

func createImage() -> Image {
    return View(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                              size: CGSize(width: 1, height: 1))).asImage()
}

extension View {
    func asImage() -> Image {
#if os(iOS)
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)

            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()

            UIGraphicsEndImageContext()

            return UIImage(cgImage: image!.cgImage!)
        }
#elseif os(macOS)
        guard let rep = bitmapImageRepForCachingDisplay(in: bounds) else { return Image() }
        cacheDisplay(in: bounds, to: rep)

        guard let cgImage = rep.cgImage else { return Image() }
        return Image(cgImage: cgImage, size: bounds.size)
#endif
    }
}
