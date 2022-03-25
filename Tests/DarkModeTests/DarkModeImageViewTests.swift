//
// DarkModeImageViewTests.swift
// DarkModeTests
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

import XCTest
@testable import PerseusDarkMode

final class DarkModeImageViewTests: XCTestCase
{
    func test_init()
    {
        let sut = DarkModeImageView()
        
        XCTAssertNil(sut.imageLight)
        XCTAssertNil(sut.imageDark)
        
        XCTAssertIdentical(sut.darkModeObserver.objectToObserve, AppearanceService.shared)
    }
    
    func test_setUp()
    {
        // arrange
        
        let sut = DarkModeImageView()
        
        // act
        
        sut.setUp(createImage(color: UIColor.white.cgColor),
                  createImage(color: UIColor.black.cgColor))
        
        // assert
        
        XCTAssertNotNil(sut.imageLight)
        XCTAssertNotNil(sut.imageDark)
    }
    
    func test_setUp_image_should_be_light_if_style_is_light()
    {
        // arrange
        
        let sut = DarkModeImageView()
        
        let light = createImage(color: UIColor.white.cgColor)
        let dark = createImage(color: UIColor.black.cgColor)
        
        // act
        
        AppearanceService.shared._style = AppearanceStyle.light
        
        sut.setUp(light, dark)
        
        // assert
        
        XCTAssertEqual(sut.image, light)
    }
    
    func test_setUp_image_should_be_dark_if_style_is_dark()
    {
        // arrange
        
        let sut = DarkModeImageView()
        
        let light = createImage(color: UIColor.white.cgColor)
        let dark = createImage(color: UIColor.black.cgColor)
        
        // act
        
        AppearanceService.shared._style = AppearanceStyle.dark
        
        sut.setUp(light, dark)
        
        // assert
        
        XCTAssertEqual(sut.image, dark)
    }
    
    func test_setUp_image_should_be_light_if_style_changed_to_light()
    {
        // arrange
        
        let sut = DarkModeImageView()
        
        let light = createImage(color: UIColor.white.cgColor)
        let dark = createImage(color: UIColor.black.cgColor)
        
        // act
        
        AppearanceService.shared._style = AppearanceStyle.dark
        
        sut.setUp(light, dark)
        
        AppearanceService.shared._style = AppearanceStyle.light
        
        // assert
        
        XCTAssertEqual(sut.image, light)
    }
    
    func test_setUp_image_should_be_dark_if_style_changed_to_dark()
    {
        // arrange
        
        let sut = DarkModeImageView()
        
        let light = createImage(color: UIColor.white.cgColor)
        let dark = createImage(color: UIColor.black.cgColor)
        
        // act
        
        AppearanceService.shared._style = AppearanceStyle.light
        
        sut.setUp(light, dark)
        
        AppearanceService.shared._style = AppearanceStyle.dark
        
        // assert
        
        XCTAssertEqual(sut.image, dark)
    }
}

// helpers

func createImage(color: CGColor) -> UIImage
{
    let view = UIView()
    view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 200, height: 200))
    
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: 200, y: 0))
    path.addLine(to: CGPoint(x: 200, y: 200))
    path.addLine(to: CGPoint(x: 0, y: 200))
    path.addLine(to: CGPoint(x: 0, y: 0))
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.fillColor = UIColor.green.cgColor
    
    view.layer.addSublayer(shapeLayer)
    
    return view.asImage()
}

extension UIView
{
    func asImage() -> UIImage
    {
        if #available(iOS 10.0, *)
        {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image
            { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        }
        else
        {
            UIGraphicsBeginImageContext(self.frame.size)
            
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}
