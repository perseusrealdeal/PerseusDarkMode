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
    name: "Perseus Dark Mode",
    platforms: [.iOS(.v9)],
    products: [
            .library(name: "Perseus Dark Mode", targets: ["PerseusDarkMode"])
        ],
    dependencies: [],
    targets: [
            .target(name: "PerseusDarkMode"),
            .testTarget(name: "DarkModeTests",
                        dependencies: ["PerseusDarkMode"])
        ]
)
