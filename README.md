# Perseus Dark Mode

[![Actions Status](https://github.com/perseusrealdeal/DarkMode/actions/workflows/main.yml/badge.svg)](https://github.com/perseusrealdeal/PerseusDarkMode/actions)
![Version](https://img.shields.io/badge/Version-1.1.0-informational.svg)
![Pod](https://img.shields.io/badge/Pod-1.1.0-informational.svg)
![Platforms](https://img.shields.io/badge/Platforms-iOS%209.3+,%20macOS%2010.9+-orange.svg)
[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-red.svg)](https://docs.swift.org/swift-book/RevisionHistory/RevisionHistory.html)
[![License](http://img.shields.io/:License-MIT-blue.svg)](https://github.com/perseusrealdeal/PerseusDarkMode/blob/7c2955094f4fd24d2b9d4c4d87780616e5361be7/LICENSE)

## Integration Capabilities

[![Standalone File](https://img.shields.io/badge/Standalone%20File-available-informational.svg)](https://github.com/perseusrealdeal/PerseusDarkMode/blob/7c2955094f4fd24d2b9d4c4d87780616e5361be7/PerseusDarkModeSingle.swift)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-4BC51D.svg)](https://github.com/apple/swift-package-manager)
[![CocoaPods manager](https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg)](https://cocoapods.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)

## Demo Apps and Others

[![Demo App](https://img.shields.io/badge/iOS%20Demo%20App-available-yellow.svg)](https://github.com/perseusrealdeal/ios.darkmode.discovery.git)
[![Demo App](https://img.shields.io/badge/macOS%20Demo%20App-available-yellow.svg)](https://github.com/perseusrealdeal/macos.darkmode.discovery.git)
[![PerseusUISystemKit](http://img.shields.io/:Satellite-PerseusUISystemKit-blue.svg)](https://github.com/perseusrealdeal/PerseusUISystemKit.git)

## Reqirements

- Xcode 10.1+
- Swift 4.2+
- iOS: 9.3+, UIKit SDK
- macOS: 10.9+, Cocoa SDK

## Third-party software

- [SwiftLint Shell Script Runner](https://github.com/perseusrealdeal/PerseusDarkMode/blob/f55af0020b4548e83ec1caf62a4960db72b72571/SucceedsPostAction.sh)

## Installation

### Step 1: Add PerseusDarkMode to a host project tree

#### Standalone 

Make a copy of the file [`PerseusDarkModeSingle.swift`](https://github.com/perseusrealdeal/PerseusDarkMode/blob/cd07e0c43efa58b3f699d8ee4d2ba3d19f0ca13f/PerseusDarkModeSingle.swift) then put it into a place required of a host project.

#### CocoaPods

Podfile should contain:

```
target "ProjectTarget" do
  use_frameworks!
  pod 'PerseusDarkMode', '1.1.0'
end
```
#### Carthage

Cartfile should contain:

```
github "perseusrealdeal/PerseusDarkMode" == 1.1.0
```

#### Swift Package Manager

- As a package dependency so Package.swift should contain the following statements:

```swift
dependencies: [
        .package(url: "https://github.com/perseusrealdeal/PerseusDarkMode.git",
            .exact("1.1.0"))
    ],
```

- As an Xcode project dependency: 

`Project in the Navigator > Package Dependencies > Add Package Dependency`

It is strongly recommended using "Exect" with the Version field.

### Step 2: Make DarkMode ready for using

#### iOS

Override the following method of the first screen to let Perseus know that system's appearance changed:

```swift
class MainViewController: UIViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            AppearanceService.processTraitCollectionDidChange(previousTraitCollection)
        }
    }
}
```

Also, if Dark Mode is released with Settings bundle put the statements into the app's delegate:

```swift
extension AppDelegate: UIApplicationDelegate {

    func applicationDidBecomeActive(_ application: UIApplication) {

        // Update Dark Mode from Settings
        if let choice = isDarkModeSettingsChanged() {
            // Change Dark Mode value in Perseus Dark Mode library
            AppearanceService.DarkModeUserChoice = choice
            // Update appearance in accoring with changed Dark Mode Style
            AppearanceService.makeUp()
        }
    }
}
```

#### iOS and macOS

Call the method `AppearanceService.makeUp()` with the app's delegate:

```swift
extension AppDelegate: UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // ... code
        
        AppearanceService.makeUp()

        return true
    }
}
```
Copy the file [`DarkModeSwitching.swift`](https://gist.github.com/perseusrealdeal/11b1bab47f13134832b859f49d9af706) into a host project for having fun with manual changing Dark Mode value.

## License MIT

Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.

- The year starts from the creation of the world according to a Slavic calendar.
- September, the 1st of Slavic year.

Have a look at [LICENSE](https://github.com/perseusrealdeal/PerseusDarkMode/blob/7c2955094f4fd24d2b9d4c4d87780616e5361be7/LICENSE) for details.

## Author

`PerseusDarkMode` was written at Novosibirsk by Mikhail Zhigulin, mzhigulin@gmail.com
