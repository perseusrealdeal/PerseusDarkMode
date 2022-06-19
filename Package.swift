// swift-tools-version:5.3
/* Package.swift

 Created by Mikhail Zhigulin in 7530.

 Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
 All rights reserved.

 Abstract:
 Package manifest for Dark Mode.
*/

import PackageDescription

let package = Package(
    name: "Dark Mode",
    platforms: [.iOS(.v9)],
    products: [
            .library(name: "Perseus Dark Mode", targets: ["PerseusDarkMode"]),
            .library(name: "Adapted System UI", targets: ["AdaptedSystemUI"])
        ],
    dependencies: [],
    targets: [
            .target(name: "PerseusDarkMode", dependencies: []),
            .target(name: "AdaptedSystemUI", dependencies: ["PerseusDarkMode"]),

            .testTarget(name: "DarkModeTests",
                        dependencies: ["PerseusDarkMode", "AdaptedSystemUI"])
        ]
)
