// swift-tools-version:5.3
/* Package.swift

 Created by Mikhail Zhigulin in 7530.

 Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.

 Licensed under the MIT license. See LICENSE file.
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
