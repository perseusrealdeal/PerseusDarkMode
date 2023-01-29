// swift-tools-version:4.2

/* Package.swift

 Created by Mikhail Zhigulin in 7530.

 Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.

 Licensed under the MIT license. See LICENSE file.
 All rights reserved.

 Abstract:
 Package manifest for Perseus Dark Mode.
 */

import PackageDescription

let package = Package(
    name: "PerseusDarkMode",
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
            name: "DarkModeTests",
            dependencies: ["PerseusDarkMode"])
        ]
)
