//
//  ColorHelper.swift
//  AdaptedSystemUI
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

#if !os(macOS)
import UIKit
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
public func rgba255(_ red  : CGFloat,
                    _ green: CGFloat,
                    _ blue : CGFloat,
                    _ alpha: CGFloat = 1.0) -> UIColor
{
    UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
}

/// Used to exctruct RGBA of the UIColor instance
public extension UIColor
{
    /// Returns red, green, and blue from 0 to 255, and alpha from 0.0 to 1.0.
    ///
    /// ```swift
    /// let rgba = UIColor.red.RGBA255
    /// print("red: \(rgba.red), green: \(rgba.green), blue: \(rgba.blue), alpha: \(rgba.alpha)")
    /// ```
    var RGBA255: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red*255, green*255, blue*255, alpha)
    }
}

/// Used only for unit testing purpose, no business means.
extension UIColor
{
    ///
    /// Used only for unit testing to take control of selecting a color scheme.
    ///
    /// If it is true and if #available(iOS 13.0, *) is also true, the branch with the color scheme for iOS 13 and higher will be selected,
    /// otherwise if it is false the color scheme for iOS 12 and lower will be selected at any way.
    ///
    internal static var _iOS13InUseAndHigherOnly: Bool = true
}
