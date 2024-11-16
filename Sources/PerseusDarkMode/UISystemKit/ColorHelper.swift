//
//  ColorHelper.swift
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

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

#if os(iOS)
public typealias Color = UIColor
#elseif os(macOS)
public typealias Color = NSColor
#endif

/// Creates the instance of UIColor using RGBA color model.
///
/// ```swift
/// let _ = rgba255(235, 235, 245, 0.6)
/// ```
/// or
///
/// ```swift
/// let _ = rgba255(255, 255, 255)
/// ```
///
/// - Parameters:
///   - red: From 0 to 255.
///   - green: From 0 to 255.
///   - blue: From 0 to 255.
///   - alpha: From 0 to 1.0.
/// - Returns: The instance of UIColor type.
public func rgba255(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0)
    -> Color { return Color(red: red/255, green: green/255, blue: blue/255, alpha: alpha) }

/// Used to exctruct RGBA of the UIColor instance
public extension Color {
    /// Returns red, green, and blue from 0 to 255, and alpha from 0.0 to 1.0.
    ///
    /// ```swift
    /// let rgba = UIColor.red.RGBA255
    /// ```
    var RGBA255: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red*255, green*255, blue*255, alpha)
    }
}
