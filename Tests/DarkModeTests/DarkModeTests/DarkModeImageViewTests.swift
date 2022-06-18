//
//  DarkModeImageViewTests.swift
//  DarkModeTests
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

#if !os(macOS)
import UIKit
#endif

import XCTest
@testable import PerseusDarkMode

final class DarkModeImageViewTests: XCTestCase {

    func test_init() {
        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1))
        let sut = DarkModeImageView(frame: frame)

        XCTAssertNil(sut.imageLight)
        XCTAssertNil(sut.imageDark)
        XCTAssertNil(sut.light)
        XCTAssertNil(sut.dark)

        XCTAssertNil(sut.image)

        XCTAssertIdentical(sut.darkModeObserver?.objectToObserve, AppearanceService.shared)
    }

    func test_setUp() {
        // arrange

        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1))
        let sut = DarkModeImageView(frame: frame)

        // act

        sut.configure(createImage(), createImage())

        // assert

        XCTAssertNotNil(sut.light)
        XCTAssertNotNil(sut.dark)

        XCTAssertNotNil(sut.image)
    }

    // MARK: - configure

    func test_configure_image_should_be_light_if_style_is_light() {
        // arrange

        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1))
        let sut = DarkModeImageView(frame: frame)

        let light = createImage()
        let dark = createImage()

        // act

        AppearanceService.shared._style = AppearanceStyle.light

        sut.configure(light, dark)

        // assert

        XCTAssertEqual(sut.image, light)
    }

    func test_configure_image_should_be_dark_if_style_is_dark() {
        // arrange

        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1))
        let sut = DarkModeImageView(frame: frame)

        let light = createImage()
        let dark = createImage()

        // act

        AppearanceService.shared._style = AppearanceStyle.dark

        sut.configure(light, dark)

        // assert

        XCTAssertEqual(sut.image, dark)
    }

    func test_configure_image_should_be_light_if_style_changed_to_light() {
        // arrange

        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1))
        let sut = DarkModeImageView(frame: frame)

        let light = createImage()
        let dark = createImage()

        // act

        AppearanceService.shared._style = AppearanceStyle.dark

        sut.configure(light, dark)

        AppearanceService.shared._style = AppearanceStyle.light

        // assert

        XCTAssertEqual(sut.image, light)
    }

    func test_configure_image_should_be_dark_if_style_changed_to_dark() {
        // arrange

        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1))
        let sut = DarkModeImageView(frame: frame)

        let light = createImage()
        let dark = createImage()

        // act

        AppearanceService.shared._style = AppearanceStyle.light

        sut.configure(light, dark)

        AppearanceService.shared._style = AppearanceStyle.dark

        // assert

        XCTAssertEqual(sut.image, dark)
    }

    // MARK: - Interface Builder

    func test_interface_builder_image_should_be_light_if_style_is_light() {
        // arrange

        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1))
        let sut = DarkModeImageView(frame: frame)

        let light = createImage()
        let dark = createImage()

        // act

        AppearanceService.shared._style = AppearanceStyle.light

        sut.imageLight = light
        sut.imageDark = dark

        // assert

        XCTAssertEqual(sut.image, light)

        XCTAssertEqual(sut.light, light)
        XCTAssertEqual(sut.imageLight, light)

        XCTAssertEqual(sut.dark, dark)
        XCTAssertEqual(sut.imageDark, dark)
    }

    func test_interface_builder_image_should_be_dark_if_style_is_dark() {
        // arrange

        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1))
        let sut = DarkModeImageView(frame: frame)

        let light = createImage()
        let dark = createImage()

        // act

        AppearanceService.shared._style = AppearanceStyle.dark

        sut.imageLight = light
        sut.imageDark = dark

        // assert

        XCTAssertEqual(sut.image, dark)

        XCTAssertEqual(sut.light, light)
        XCTAssertEqual(sut.imageLight, light)

        XCTAssertEqual(sut.dark, dark)
        XCTAssertEqual(sut.imageDark, dark)
    }

    func test_interface_builder_should_be_light_if_style_changed_to_light() {
        // arrange

        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1))
        let sut = DarkModeImageView(frame: frame)

        let light = createImage()
        let dark = createImage()

        // act

        AppearanceService.shared._style = AppearanceStyle.dark

        sut.imageLight = light
        sut.imageDark = dark

        AppearanceService.shared._style = AppearanceStyle.light

        // assert

        XCTAssertEqual(sut.image, light)
    }

    func test_interface_builder_image_should_be_dark_if_style_changed_to_dark() {
        // arrange

        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1))
        let sut = DarkModeImageView(frame: frame)

        let light = createImage()
        let dark = createImage()

        // act

        AppearanceService.shared._style = AppearanceStyle.light

        sut.imageLight = light
        sut.imageDark = dark

        AppearanceService.shared._style = AppearanceStyle.dark

        // assert

        XCTAssertEqual(sut.image, dark)
    }
}
