// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name        : "Dark Mode",
    platforms   : [.iOS(.v9)],
    products    : [.library(name: "Perseus Dark Mode", targets: ["PerseusDarkMode"]),],
    dependencies: [],
    targets     :
        [
            .target(name: "PerseusDarkMode", dependencies: []),
            .testTarget(name: "DarkModeTests", dependencies: ["PerseusDarkMode"]),
        ]
)
