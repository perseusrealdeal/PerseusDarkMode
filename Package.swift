// swift-tools-version:5.3
/* Package.swift

 Created by Mikhail Zhigulin in 2022.

 Copyright (c) 2022 Mikhail Zhigulin of Novosibirsk.
 All rights reserved.

 Abstract:
 Package manifest for Dark Mode.
*/

import PackageDescription

let package = Package(
    name: "PerseusDarkMode",
    platforms: [.iOS(.v9)],
    products: [
            .library(name: "PerseusDarkMode", targets: ["PerseusDarkMode"])
        ],
    targets: [
            .target(name: "PerseusDarkMode"),
            .testTarget(name: "DarkModeTests",
                        dependencies: ["PerseusDarkMode"])
        ]
)
