// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name        : "Dark Mode",
    platforms   : [.iOS(.v9)],
    products    :
        [
            .library(name: "Perseus Dark Mode", targets: ["PerseusDarkMode"]),
            .library(name: "Adopted System UI", targets: ["AdoptedSystemUI"]),
        ],
    dependencies: [],
    targets     :
        [
            .target(name: "PerseusDarkMode", dependencies: []),
            .target(name: "AdoptedSystemUI", dependencies: ["PerseusDarkMode"]),
            
            .testTarget(name        : "DarkModeTests",
                        dependencies: ["PerseusDarkMode", "AdoptedSystemUI"]),
        ]
)
