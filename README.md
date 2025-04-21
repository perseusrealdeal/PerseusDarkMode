# PerseusDarkMode — Xcode 14.2+

[`iOS approbation app`](https://github.com/perseusrealdeal/TheOneRing) [`macOS approbation app`](https://github.com/perseusrealdeal/Arkenstone)

> The light-weight darkness in Swift you can force. Hereinafter PDM stands for Perseus Dark Mode.<br/>

> - To build option kinda `Night/Day/System Mode` or `On/Off/System Dark Mode`.<br/>
> - To be awared of Dark Mode changes if you need.<br/>

> `PDM` is a single author and personale solution developed in `person-to-person` relationship paradigm.

[![Actions Status](https://github.com/perseusrealdeal/PerseusDarkMode/actions/workflows/main.yml/badge.svg)](https://github.com/perseusrealdeal/PerseusDarkMode/actions/workflows/main.yml)
[![Style](https://github.com/perseusrealdeal/PerseusDarkMode/actions/workflows/swiftlint.yml/badge.svg)](https://github.com/perseusrealdeal/PerseusDarkMode/actions/workflows/swiftlint.yml)
[![Version](https://img.shields.io/badge/Version-2.0.0-green.svg)](/CHANGELOG.md)
[![Platforms](https://img.shields.io/badge/Platforms-macOS%2010.13+Cocoa_|_iOS%2011.0+UIKit-orange.svg)](https://en.wikipedia.org/wiki/List_of_Apple_products)
[![Xcode 14.2](https://img.shields.io/badge/Xcode-14.2+-red.svg)](https://en.wikipedia.org/wiki/Xcode)
[![Swift 5.7](https://img.shields.io/badge/Swift-5.7-red.svg)](https://www.swift.org)
[![License](http://img.shields.io/:License-MIT-blue.svg)](/LICENSE)

## Integration Capabilities

[![Standalone](https://img.shields.io/badge/Standalone-available-informational.svg)](/PDMStar.swift)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-4BC51D.svg)](/Package.swift)

> Use Stars to adopt [`PDM`](/PDMStar.swift) for the specifics you need.

# Support Code (external part of PDM)

[![Standalone](https://img.shields.io/badge/Standalone-available-informational.svg)](/PDMSupportingStar.swift)
[![License](http://img.shields.io/:License-Unlicense-green.svg)](http://unlicense.org/)

> [`PDMSupportingStar.swift`](/PDMSupportingStar.swift) is a collection of classes a widly helpful in accord with PDM.

## Approbation Matrix

> [`A3 Environment and Approbation`](/APPROBATION.md) / [`CHANGELOG`](/CHANGELOG.md) for details.

## In brief > Idea to use, the Why

The Darkness. To take control of the Dark in the app.

## Build requirements

- [macOS Monterey 12.7.6+](https://apps.apple.com/by/app/macos-monterey/id1576738294) / [Xcode 14.2+](https://developer.apple.com/services-account/download?path=/Developer_Tools/Xcode_14.2/Xcode_14.2.xip)

## First-party software

- [ConsolePerseusLogger](https://github.com/perseusrealdeal/ConsolePerseusLogger) / [1.1.0](https://github.com/perseusrealdeal/ConsolePerseusLogger/releases/tag/1.1.0)

## Third-party software

- Style [SwiftLint](https://github.com/realm/SwiftLint) / [Shell Script](/SucceedsPostAction.sh)
- Action [mxcl/xcodebuild@v3.3](https://github.com/mxcl/xcodebuild/releases/tag/v3.3.0)
- Action [cirruslabs/swiftlint-action@v1](https://github.com/cirruslabs/swiftlint-action/releases/tag/v1.0.0)

# Installation

`Step 1:` Import the Darkness either with SPM or standalone

> Standalone: the single source code file [PDMStar.swift](/PDMStar.swift)

> Swift Package Manager: `https://github.com/perseusrealdeal/PerseusDarkMode`

## Steps for Cocoa macOS project

`Step 2:` Call to `force` if `applicationDidFinishLaunching` in the AppDelegate

```swift

import Cocoa
import PerseusDarkMode

class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        DarkModeAgent.force(DarkModeUserChoice)
    }
}

```

`Step 3:` Register the MainWindowController

```swift

import Cocoa
import PerseusDarkMode

class MainWindowController: NSWindowController, NSWindowDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()

        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
    }

    @objc private func makeUp() {
    
    // Called every time if the DarkMode changes.
    // The current DarkMode value is reliable here.
    
    let isDark = DarkMode.style == .dark
    let _ = isDark ? "It's dark" : "No dark"
    
    }
}

```

## Steps for UIKit iOS project

`Step 2:` Call to `force` if `didFinishLaunchingWithOptions` in the AppDelegate

```swift

import UIKit
import PerseusDarkMode

class AppDelegate: UIResponder { var window: UIWindow? }

extension AppDelegate: UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Register Settings Bundle
        registerSettingsBundle()

        // Init the app's window
        window = UIWindow(frame: UIScreen.main.bounds)

        // Give it a root view for the first screen
        window!.rootViewController = MainViewController.storyboardInstance()
        window!.makeKeyAndVisible()
        
        DarkModeAgent.force(DarkModeUserChoice)
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {

        // Actualize Dark Mode style to Settings Bundle
        if let choice = DarkModeAgent.isDarkModeSettingsKeyChanged() {
            DarkModeAgent.force(choice)
        }
    }
}

```

`Step 3:` Register the MainViewController and process traitCollectionDidChange event

```swift

import UIKit
import PerseusDarkMode

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            DarkModeAgent.processTraitCollectionDidChange(previousTraitCollection)
        }
    }
    
    @objc private func makeUp() {
    
    // Called every time if the DarkMode changes.
    // The current DarkMode value is reliable here.
    
    let isDark = DarkMode.style == .dark
    let _ = isDark ? "It's dark" : "No dark"
    
    }
}

```

# Usage

## Force Dark Mode

> TODO How to force DarkMode?

## Get awared of DarkMode Changes

> Perseus Dark Mode sensitive code should be placed within block that is called every time if DarkMode changes.

> TODO: Registering and makeUp()

> TODO: KVO and makeUp()

## React to DarkMode Changes

> `Use Case -` Custom Color sensitive to DarkMode.

```swift

import PerseusDarkMode

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

#if os(iOS)
public typealias Color = UIColor
#elseif os(macOS)
public typealias Color = NSColor
#endif

public func rgba255(_ red: CGFloat,
                    _ green: CGFloat,
                    _ blue: CGFloat,
                    _ alpha: CGFloat = 1.0) -> Color {
    return Color(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
}

extension Color {
    public static var customRed: Color {
        return DarkModeAgent.shared.style == .light ?
            rgba255(255, 59, 48) : rgba255(255, 69, 58)
    }
}

```

> Use Custom DarkMode sensitive color.

```swift

    // Called every time if the DarkMode changes. KVO Method or registered. 
    @objc private func makeUp() {
        self.backgroundColor = .customRed
    }

```

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
- Git clients: [SmartGit](https://syntevo.com/) and [GitHub Desktop](https://github.com/apps/desktop)

# Author

> Mikhail A. Zhigulin of Novosibirsk.
