//
// ColorHelper.swift
// AdaptedSystemUI
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

import UIKit

public func rgba255(_ red  : CGFloat,
                    _ green: CGFloat,
                    _ blue : CGFloat,
                    _ alpha: CGFloat = 1.0) -> UIColor
{
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
}

public extension UIColor
{
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
