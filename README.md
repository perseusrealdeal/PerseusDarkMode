# PerseusDarkMode — Xcode 14.2+

[`iOS approbation app`](https://github.com/perseusrealdeal/iOS.DarkMode.Discovery) [`macOS approbation app`](https://github.com/perseusrealdeal/macOS.DarkMode.Discovery)

`PerseusDarkMode` is a single author and personale solution developed in `person-to-person` relationship paradigm.

[![Actions Status](https://github.com/perseusrealdeal/PerseusDarkMode/actions/workflows/main.yml/badge.svg)](https://github.com/perseusrealdeal/PerseusDarkMode/actions/workflows/main.yml)
[![Style](https://github.com/perseusrealdeal/PerseusDarkMode/actions/workflows/swiftlint.yml/badge.svg)](https://github.com/perseusrealdeal/PerseusDarkMode/actions/workflows/swiftlint.yml)
[![Version](https://img.shields.io/badge/Version-2.0.0-green.svg)](/CHANGELOG.md)
[![Platforms](https://img.shields.io/badge/Platforms-macOS%2010.13+_|_iOS%2011.0+-orange.svg)](https://en.wikipedia.org/wiki/List_of_Apple_products)
[![Xcode 14.2](https://img.shields.io/badge/Xcode-14.2+-red.svg)](https://en.wikipedia.org/wiki/Xcode)
[![Swift 5.7](https://img.shields.io/badge/Swift-5.7-red.svg)](https://www.swift.org)
[![License](http://img.shields.io/:License-MIT-blue.svg)](/LICENSE)

## Integration Capabilities

[![Standalone](https://img.shields.io/badge/Standalone-available-informational.svg)](/PerseusDarkModeStar.swift)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-4BC51D.svg)](/Package.swift)

## Approbation Matrix

> [A3 Environment](https://docs.google.com/document/d/1K2jOeIknKRRpTEEIPKhxO2H_1eBTof5uTXxyOm5g6nQ/edit?usp=sharing) / [Approbation Results](/APPROBATION.md) / [CHANGELOG](/CHANGELOG.md) for details.

## In brief > Idea to use, the Why

Package in Swift unified for both iOS and macOS to support Dark Mode capabilities of getting elder devices.

## Build system requirements

- [macOS Monterey 12.7.6+](https://apps.apple.com/by/app/macos-monterey/id1576738294) / [Xcode 14.2+](https://developer.apple.com/services-account/download?path=/Developer_Tools/Xcode_14.2/Xcode_14.2.xip)

# First-party software

- [ConsolePerseusLogger](https://github.com/perseusrealdeal/ConsolePerseusLogger) / [1.0.3](https://github.com/perseusrealdeal/ConsolePerseusLogger/releases/tag/1.0.3)

# Installation

## Standalone

Use the single source code file [PerseusDarkModeStar.swift](https://github.com/perseusrealdeal/PerseusDarkMode/blob/b772b406c744be641fee55c7033b42e7991123f3/PerseusDarkModeStar.swift) directly in your project.

## Swift Package Manager

`Project in the Navigator > Package Dependencies > Add Package Dependency`

> Put the following line in the package search field:

`https://github.com/perseusrealdeal/PerseusDarkMode`

> Dependency rule: 

`Up to Next Major Version`

# Usage

`Step 1:` **Install the package dependency in the prefered way either Standalone or SPM**

`Step 2 A:` **Setup dependency for iOS**

`Override traitCollectionDidChange` of the main screen (the first one, top screen)

```swift

class MainViewController: UIViewController {

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            DarkModeAgent.processTraitCollectionDidChange(previousTraitCollection)
        }
    }
}
```

`Settings bundle` used for switching DarkMode, so put the statements into the app's delegate

```swift

extension AppDelegate: UIApplicationDelegate {

    func applicationDidBecomeActive(_ application: UIApplication) {
        log.message("[\(type(of: self))].\(#function)")

        // Update Dark Mode from Settings
        if let choice = DarkModeAgent.isDarkModeChanged() {
            // Change Dark Mode value in Perseus Dark Mode library
            DarkModeAgent.DarkModeUserChoice = choice
            // Update appearance in accoring with changed Dark Mode Style
            DarkModeAgent.makeUp()
        }
    }
}

```

`Step 2 B:` **Setup dependency for macOS**

`Make a call in applicationDidFinishLaunching` DarkModeAgent.makeUp()

```swift

class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        log.message("Launching with business matter purpose...", .info)
        log.message("[\(type(of: self))].\(#function)")

        DarkModeAgent.makeUp()
    }
}

```

`Step 3:` **Apply DarkMode for UI element**

Put `DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))` in UI element's config method, so each time when DarkModeAgent.makeUp() called all registered makeUp methods will be called.

`UIViewController` : #selector(makeUp) to switch DarkMode

```swift
class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
    }
    
    @objc private func makeUp() {
        view.backgroundColor = .customPrimaryBackground

        let choice = DarkModeAgent.DarkModeUserChoice
        log.message("\(choice)") // .auto or .on or .off
        
        // Update all depended elements.
    }
}
```

`UIView` : #selector(makeUp) to switch DarkMode

```swift
class Panel: UIView {

    // Initiating

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }
    
    private func commonInit() {

        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
    }
    
    @objc private func makeUp() {
        // Update all depended elements.
    }
}
```

There is another way to be notified of Dark Mode—KVO.

> [DarkModeImageView](https://github.com/perseusrealdeal/PerseusDarkMode/blob/7266d21cf687b9d5edd6ef6e6de6d65a6463142a/Sources/PerseusDarkMode/UISystemKit/DarkModeImageView.swift) class is an expressive sample of Dark Mode KVO usage for both macOS and iOS as well.

All usage tips in detail can be found in [`iOS approbation app`](https://github.com/perseusrealdeal/iOS.DarkMode.Discovery) & [`macOS approbation app`](https://github.com/perseusrealdeal/macOS.DarkMode.Discovery)

# Third-party software

- Style [SwiftLint](https://github.com/realm/SwiftLint) / [Shell Script](/SucceedsPostAction.sh)
- Action [mxcl/xcodebuild@v3.3](https://github.com/mxcl/xcodebuild/releases/tag/v3.3.0)
- Action [cirruslabs/swiftlint-action@v1](https://github.com/cirruslabs/swiftlint-action/releases/tag/v1.0.0)

# Points taken into account

- Preconfigured Swift Package manifest [Package.swift](/Package.swift)
- Preconfigured SwiftLint config [.swiftlint.yml](/.swiftlint.yml)
- Preconfigured SwiftLint CI [swiftlint.yml](/.github/workflows/swiftlint.yml)
- Preconfigured GitHub config [.gitignore](/.gitignore)
- Preconfigured GitHub CI [main.yml](/.github/workflows/main.yml)

# License MIT

Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk<br/>
Copyright © 7533 PerseusRealDeal

- The year starts from the creation of the world according to a Slavic calendar.
- September, the 1st of Slavic year. It means that "Sep 01, 2024" is the beginning of 7533.

[LICENSE](/LICENSE) for details.

## Credits

<table>
<tr>
    <td>Balance and Control</td>
    <td>kept by</td>
    <td>Mikhail A. Zhigulin</td>
</tr>
<tr>
    <td>Source Code</td>
    <td>written by</td>
    <td>Mikhail A. Zhigulin</td>
</tr>
<tr>
    <td>Documentation</td>
    <td>prepared by</td>
    <td>Mikhail A. Zhigulin</td>
</tr>
<tr>
    <td>Product Approbation</td>
    <td>tested by</td>
    <td>Mikhail A. Zhigulin</td>
</tr>
</table>

- Language support: [Reverso](https://www.reverso.net/)
- Git client: [SmartGit](https://syntevo.com/)

# Author

> Mikhail A. Zhigulin of Novosibirsk.
