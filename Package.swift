// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name        : "DarkMode",
    platforms   : [.iOS(.v9)],
    products    : [.library(name: "PerseusDarkMode", targets: ["PerseusDarkMode"]),],
    dependencies: [],
    targets     :
        [
            .target(name: "PerseusDarkMode", dependencies: []),
            .testTarget(name: "DarkModeTests", dependencies: ["PerseusDarkMode"]),
        ]
)
