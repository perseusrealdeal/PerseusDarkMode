# Perseus Dark Mode

[![Actions Status](https://github.com/perseusrealdeal/DarkMode/actions/workflows/main.yml/badge.svg)](https://github.com/perseusrealdeal/PerseusDarkMode/actions)
![Version](https://img.shields.io/badge/Version-1.1.5-informational.svg)
[![Pod](https://img.shields.io/badge/Pod-1.1.4-informational.svg)](/PerseusDarkMode.podspec)
![Platforms](https://img.shields.io/badge/Platforms-iOS%209.3+,%20macOS%2010.9+-orange.svg)
[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-red.svg)](https://docs.swift.org/swift-book/RevisionHistory/RevisionHistory.html)
[![License](http://img.shields.io/:License-MIT-blue.svg)](/LICENSE)

## Integration Capabilities

[![Standalone](https://img.shields.io/badge/Standalone-available-informational.svg)](/PerseusDarkModeSingle.swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)
[![CocoaPods manager](https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg)](/PerseusDarkMode.podspec)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-4BC51D.svg)](/Package.swift)

## Demo Apps and Others

[![Demo App](https://img.shields.io/badge/iOS%20Demo%20App-available-yellow.svg)](https://github.com/perseusrealdeal/ios.darkmode.discovery.git)
[![Demo App](https://img.shields.io/badge/macOS%20Demo%20App-available-yellow.svg)](https://github.com/perseusrealdeal/macos.darkmode.discovery.git)
[![PerseusUISystemKit](http://img.shields.io/:Satellite-PerseusUISystemKit-blue.svg)](https://github.com/perseusrealdeal/PerseusUISystemKit.git)
[![XcodeTemplateProject](http://img.shields.io/:Template-XcodeTemplateProject-blue.svg)](https://github.com/perseusrealdeal/XcodeTemplateProject.git)

# In Brief

> This library lets a developer being awared of Dark Mode via a variable `DarkMode.style`. Also, with this library it is possible to change the value of Dark Mode in runtime easily with standalone lib [DarkModeSwitching](https://gist.github.com/perseusrealdeal/11b1bab47f13134832b859f49d9af706).

```swift
changeDarkModeManually(.off) // .on or .auto
```
Sample screen for changing Dark Mode option [here for macOS](https://github.com/perseusrealdeal/macos.darkmode.discovery) and [here for iOS](https://github.com/perseusrealdeal/ios.darkmode.discovery).

# Reqirements

- Xcode 10.1+
- Swift 4.2+
- iOS: 9.3+, UIKit SDK
- macOS: 10.9+, AppKit SDK

# First-party software

- [PerseusLogger](https://gist.github.com/perseusrealdeal/df456a9825fcface44eca738056eb6d5)

# Third-party software

- [SwiftLint Shell Script Runner](/SucceedsPostAction.sh)
- [SwiftLint](https://github.com/realm/SwiftLint) / [0.31.0: Busy Laundromat](https://github.com/realm/SwiftLint/releases/tag/0.31.0) for macOS High Sierra

# Installation

> ***Using "Exact" with the Version field is strongly recommended.***

## Step 1: Add PerseusDarkMode to a host project tree

### Standalone 

Make a copy of the file [`PerseusDarkModeSingle.swift`](/PerseusDarkModeSingle.swift) then put it into a place required of a host project.

### Carthage

Cartfile should contain:

```carthage
github "perseusrealdeal/PerseusDarkMode" == 1.1.5
```

Some Carthage usage tips placed [here](https://gist.github.com/perseusrealdeal/8951b10f4330325df6347aaaa79d3cf2).

### CocoaPods

Podfile should contain:

```ruby
target "ProjectTarget" do
  use_frameworks!
  pod 'PerseusDarkMode', '1.1.4'
end
```

### Swift Package Manager

- As a package dependency so Package.swift should contain the following statements:

```swift
dependencies: [
        .package(url: "https://github.com/perseusrealdeal/PerseusDarkMode.git",
            .exact("1.1.5"))
    ],
```

- As an Xcode project dependency: 

`Project in the Navigator > Package Dependencies > Add Package Dependency`

> ***Using "Exact" with the Version field is strongly recommended.***

## Step 2: Make DarkMode ready for using

### iOS

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
Used functions are distributed via standalone file [`DarkModeSwitching.swift`](https://gist.github.com/perseusrealdeal/11b1bab47f13134832b859f49d9af706).

### iOS and macOS

Call the method `AppearanceService.makeUp()` with the app's delegate if appearance changing is going to take place:

```swift
extension AppDelegate: UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // ... code
        
        // Call AppearanceService.makeUp() method if AppearanceService.register(:, :)
        // is taken into account
        AppearanceService.makeUp()

        // ... otherwise call AppearanceService.recalculateStyleIfNeeded()
        // to load DarkMode.style from user defaults
        // AppearanceService.recalculateStyleIfNeeded()
    }
}
```
Copy the file [`DarkModeSwitching.swift`](https://gist.github.com/perseusrealdeal/11b1bab47f13134832b859f49d9af706) into a host project for having fun with manual changing Dark Mode value.

# Usage

Each time if Dark Mode changed the mentioned method `#selector(makeUp)` called, but registering is required:
```swift
class MainViewController: UIViewController {

    // At any view controller where changing is required

    override func viewDidLoad() {
        super.viewDidLoad()

        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))
    }

    @objc private func makeUp() {
        print("^_^ \(AppearanceService.DarkModeUserChoice)"

        switch DarkMode.style {
        case .light:
            // make drawings for light mode
            break
        case .dark:
            // make drawings for dark mode
            break
        }
    }
}
```

There is another way to be notified of Dark Mode—KVO. Sample [here](https://github.com/perseusrealdeal/macos.darkmode.discovery).

# License MIT

Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.

- The year starts from the creation of the world according to a Slavic calendar.
- September, the 1st of Slavic year.

[LICENSE](/LICENSE) for details.

# Author

> `PerseusDarkMode` was written at Novosibirsk by Mikhail Zhigulin i.e. me, mzhigulin@gmail.com.

> Mostly I'd like thank my lovely parents for supporting me in all my ways.
