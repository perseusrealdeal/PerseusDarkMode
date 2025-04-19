// swift-tools-version:5.7

/* Package.swift
 Version: 2.0.0

 Created by Mikhail Zhigulin in 7530.

 Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk
 Copyright © 7533 PerseusRealDeal

 Licensed under the MIT license. See LICENSE file.
 All rights reserved.

 Abstract:
 Package manifest for Perseus Dark Mode.
*/

import PackageDescription

let package = Package(
    name: "PerseusDarkMode",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "PerseusDarkMode",
            targets: ["PerseusDarkMode"])
        ],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "PerseusDarkMode",
            dependencies: []),
        .testTarget(
            name: "UnitTests",
            dependencies: ["PerseusDarkMode"])
        ]
)
