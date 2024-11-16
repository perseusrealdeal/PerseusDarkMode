//
//  DarkModeImageViewTests.swift
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
// swiftlint:disable file_length
//

import XCTest

@testable import PerseusDarkMode

final class DarkModeImageViewTests: XCTestCase {

    func test_init() {

        // arrange

        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1))
        let sut = DarkModeImageView(frame: frame)

        let objectToObserve = sut.darkModeObserver?.objectToObserve as AnyObject
        let observeredObject = AppearanceService.shared as AnyObject

        XCTAssertNil(sut.imageLight)
        XCTAssertNil(sut.imageDark)
        XCTAssertNil(sut.image)

        // assert

#if os(iOS)
        XCTAssertNil(sut.light)
        XCTAssertNil(sut.dark)

        XCTAssertEqual(ObjectIdentifier(objectToObserve), ObjectIdentifier(observeredObject))
#endif

#if os(macOS)
        XCTAssertEqual(objectToObserve.objectID, observeredObject.objectID)
#endif
    }

    func test_setUp() {

        // arrange

        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1))
        let sut = DarkModeImageView(frame: frame)

        // act

        sut.configure(createImage(), createImage())

        // assert

#if os(iOS)
        XCTAssertNotNil(sut.light)
        XCTAssertNotNil(sut.dark)
#endif

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

        AppearanceService.shared.hidden_style = AppearanceStyle.light

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

        AppearanceService.shared.hidden_style = AppearanceStyle.dark

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

        AppearanceService.shared.hidden_style = AppearanceStyle.dark

        sut.configure(light, dark)

        AppearanceService.shared.hidden_style = AppearanceStyle.light

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

        AppearanceService.shared.hidden_style = AppearanceStyle.light

        sut.configure(light, dark)

        AppearanceService.shared.hidden_style = AppearanceStyle.dark

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

        AppearanceService.shared.hidden_style = AppearanceStyle.light

        sut.imageLight = light
        sut.imageDark = dark

        // assert

        XCTAssertEqual(sut.image, light)

        XCTAssertEqual(sut.imageLight, light)
        XCTAssertEqual(sut.imageDark, dark)

#if os(iOS)
        XCTAssertEqual(sut.light, light)
        XCTAssertEqual(sut.dark, dark)
#endif
    }

    func test_interface_builder_image_should_be_dark_if_style_is_dark() {
        // arrange

        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1))
        let sut = DarkModeImageView(frame: frame)

        let light = createImage()
        let dark = createImage()

        // act

        AppearanceService.shared.hidden_style = AppearanceStyle.dark

        sut.imageLight = light
        sut.imageDark = dark

        // assert

        XCTAssertEqual(sut.image, dark)

        XCTAssertEqual(sut.imageLight, light)
        XCTAssertEqual(sut.imageDark, dark)

#if os(iOS)
        XCTAssertEqual(sut.light, light)
        XCTAssertEqual(sut.dark, dark)
#endif
    }

    func test_interface_builder_should_be_light_if_style_changed_to_light() {
        // arrange

        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1))
        let sut = DarkModeImageView(frame: frame)

        let light = createImage()
        let dark = createImage()

        // act

        AppearanceService.shared.hidden_style = AppearanceStyle.dark

        sut.imageLight = light
        sut.imageDark = dark

        AppearanceService.shared.hidden_style = AppearanceStyle.light

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

        AppearanceService.shared.hidden_style = AppearanceStyle.light

        sut.imageLight = light
        sut.imageDark = dark

        AppearanceService.shared.hidden_style = AppearanceStyle.dark

        // assert

        XCTAssertEqual(sut.image, dark)
    }
}
