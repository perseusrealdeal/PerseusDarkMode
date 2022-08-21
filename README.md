Perseus Dark Mode
======================================
[![Actions Status](https://github.com/perseusrealdeal/DarkMode/actions/workflows/CI.yml/badge.svg)](https://github.com/perseusrealdeal/DarkMode/actions)
![Version](https://img.shields.io/badge/Version-1.0.5-green.svg)
![Pod](https://img.shields.io/badge/Pod-1.0.5-green.svg)
[![Platforms iOS 9+](https://img.shields.io/badge/Platform-iOS%209.0+-orange.svg)](https://en.wikipedia.org/wiki/IOS_9)
[![Platforms macOS 10.9+](https://img.shields.io/badge/Platform-macOS%2010.9+-orange.svg)](https://en.wikipedia.org/wiki/MacOS)
[![SDK UIKit](https://img.shields.io/badge/SDK-UIKit,%20Cocoa%20-blueviolet.svg)](https://developer.apple.com/documentation/uikit)
[![Swift 5.3](https://img.shields.io/badge/Swift-5.3-red.svg)](https://docs.swift.org/swift-book/RevisionHistory/RevisionHistory.html)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-informational.svg)](https://github.com/apple/swift-package-manager)
[![CocoaPods manager](https://img.shields.io/badge/CocoaPods%20Manager-compatible-informational.svg)](https://cocoapods.org)
[![Carthage manager](https://img.shields.io/badge/Carthage%20Manager-compatible-informational.svg)](https://github.com/Carthage/Carthage)
[![License](http://img.shields.io/:License-MIT-blue.svg)](https://github.com/perseusrealdeal/DarkMode/blob/ddf37bd9889914c16c494274f178fa3aab6f3d5b/LICENSE)

- Have a look of demo apps, [iOS App](https://github.com/perseusrealdeal/ios.darkmode.discovery.git) and [macOS App](https://github.com/perseusrealdeal/macos.darkmode.discovery.git). 
- There is a satellite lib [PerseusUISystemKit](https://github.com/perseusrealdeal/PerseusUISystemKit.git).

[![Standalone File](https://img.shields.io/badge/Standalone%20File-available-red.svg)](https://github.com/perseusrealdeal/PerseusDarkMode/blob/88de223782cad8d70f75b55fd6fb085577ce92d2/PerseusDarkModeSingle.swift)
[![Demo App](https://img.shields.io/badge/iOS%20Demo%20App-available-ff6964.svg)](https://github.com/perseusrealdeal/ios.darkmode.discovery.git)
[![Demo App](https://img.shields.io/badge/macOS%20Demo%20App-available-ff6964.svg)](https://github.com/perseusrealdeal/macos.darkmode.discovery.git)
[![PerseusUISystemKit](http://img.shields.io/:Satellite-PerseusUISystemKit-blue.svg)](https://github.com/perseusrealdeal/PerseusUISystemKit.git)

# Table of contents

[Introductory remarks](#section1)
1. [Build tools & Installation](#section2)
2. [Solution key statements](#section3)
3. [Dark Mode table decision](#section4)
4. [Switching Dark Mode](#section5)
5. [Catching Dark Mode triggered](#section6)

Samples:
- [Sample Use Case of Dark Mode](#section7)

[License](#license)

---

## Introductory remarks <a name="section1"></a>

Perseus Dark Mode gives a control of Apple's Dark Mode even for early Apple devices starting from iOS 9.0.

## 1. Build tools & Installation <a name="section2"></a>

Tools used for designing the solution:
+ Xcode 13.3.1
+ Device iPod Touch iOS 9.3.5 (5th, 13G36) 
+ Device iPad Air iOS 12.5.5 (iPad4,2 model, 16H62)
+ Simulator iPhone 12 mini (iOS 15.4, 19E240)

The solution can be used via `swift package manager`, `CocoaPods dependency manager`, `Carthage dependency manager` and as a `standalone single file` as well.

File `PerseusDarkModeSingle.swift` located in the package root and is dedicated for the standalone usage—can be copied and pasted into a host project tree under the same [license](#license).

## 2. Solution key statements <a name="section3"></a>

`Dark Mode is a Singleton object`

```swift
public class AppearanceService {

    public static var shared: DarkMode = { DarkMode() }()
    private init() { }

}
```

`Dark Mode is a complex object`

```swift
public protocol DarkModeProtocol {

    var Style: AppearanceStyle { get }
    var SystemStyle: SystemStyle { get }

    dynamic var StyleObservable: Int { get }

}

extension DarkMode: DarkModeProtocol { }
```

`Dark Mode is hosted as a property in a screen object`

```swift
public extension UIResponder { var DarkMode: DarkModeProtocol { AppearanceService.shared }}
```

## 3. Dark Mode table decision <a name="section4"></a>

`Dark Mode option values`

```swift
public enum DarkModeOption: Int {

    case auto = 0
    case on   = 1
    case off  = 2

}
```

`Dark Mode System values`

```swift
public enum SystemStyle: Int {

    case unspecified = 0
    case light       = 1
    case dark        = 2

}
```

`Dark Mode decision table`

Dark Mode decision table makes decision on `Appearance style` that can be either light or dark:

```swift
public enum AppearanceStyle: Int {

    case light = 0
    case dark  = 1

}
```

Dark Mode default value is light:

```swift
public let DARK_MODE_STYLE_DEFAULT = AppearanceStyle.light
```

|                  | auto      | on   | off   |
| ---------------- | :-------: |:----:| :----:|
| **.unspecified** | default   | dark | light |
| **.light**       | light     | dark | light |
| **.dark**        | dark      | dark | light |

In case if dark mode option is in auto and system style is .unspecified, default value is applied for iOS 12 and eariler, but, for iOS 13 and higher, device system appearance mode is.

Apps that are based on Perseus Dark Mode rely on AppearanceStyle as a business matter value available for accessing via UIResponder extension:

```swift
import UIKit

import PerseusDarkMode

class MyView: UIView  { 
    func functionName() { 
        print("\(self.DarkMode.Style)")
    } 
}
```

## 4. Switching Dark Mode <a name="section5"></a>

`Case: Manually`

Inside your app there is only one way to let it know that you'd like to change Dark Mode. Use DarkModeUserChoice hosted as a property in AppearanceService to assign the value of Dark Mode you want.

So, in your code it should look like this:

```swift
let choice = DarkModeOption.auto

AppearanceService.DarkModeUserChoice = choice

AppearanceService.makeUp()
```

And do not forget call makeUp() if you want to be notified via NotificationCenter.

`Case: Via System`

To match the system appearance mode call `AppearanceService.processTraitCollectionDidChange(_:)` method once in `traitCollectionDidChange(_:)` of the main screen (UIViewController or UIWindow). The sample is below:

```swift
import UIKit
import PerseusDarkMode

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection? {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            AppearanceService.processTraitCollectionDidChange(previousTraitCollection)
        }
    }

    @objc private func makeUp() {
        // Point to define a reaction to Dark Mode event is here
    }

    private func configure() { }
}
```

## 5. Catching Dark Mode triggered <a name="section6"></a>

`Case: Using KVO`

Create an observer somewhere in your code like this:

```swift
 var observer: DarkModeObserver?
 
 observer = DarkModeObserver()
```

Then, give it a closure to run your code each time when Dark Mode is changing:

```swift

observer?.action = { newStyle in 

        // Point to define a reaction to Dark Mode event is here

    }
```

or like this:

```swift
var observer = DarkModeObserver { newStyle in

        // Point to define a reaction to Dark Mode event is here

    }
```

`Case: Getting informed by NotificationCenter`

To get notified by NotificationCenter your object should be registered with AppearanceService:

```swift
import UIKit

class MyView: UIView { 
    @objc func makeUp() { 
        // Point to define a reaction to Dark Mode event is here
    } 
}

let view = MyView()

AppearanceService.register(stakeholder: view, selector: #selector(view.makeUp))
```

`Call AppearanceService.makeUp()`

Use AppearanceService.makeUp() to call all selected makeUp methods:

```swift
AppearanceService.makeUp()
```

It should be called first time in `didFinishLaunchingWithOptions`:

```swift
import UIKit

import PerseusDarkMode

class AppDelegate: UIResponder { var window: UIWindow? }

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Init the app's window
        window = UIWindow(frame: UIScreen.main.bounds)

        // Give it a root view for the first screen
        window!.rootViewController = MainViewController.storyboardInstance()
        window!.makeKeyAndVisible()

        // And, finally, apply a new style for all screens
        AppearanceService.makeUp()

        return true
    }
}

```

## 6. Sample Use Case of Dark Mode <a name="section7"></a>

```swift
import UIKit
import PerseusDarkMode

class MainViewController: UIViewController {

    let darkModeObserver = DarkModeObserver()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))

        darkModeObserver.action = { newStyle in

                // Point to define a reaction to Dark Mode event is here
                print("\(newStyle), \(self.DarkMode.Style)")
            }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *) {
            AppearanceService.processTraitCollectionDidChange(previousTraitCollection)
        }
    }

    @objc private func makeUp() {
        // Point to define a reaction to Dark Mode event is here
        view.backgroundColor = .systemRed
    }

    private func configure() { }
}
```

`In addition to sample use case`

If your view or view controller is declared as a lazy one or a sub view like UITableViewCell it's not bad to add the following condition after registering:

```swift
if AppearanceService.isEnabled { makeUp() }
```

For instance, here is a definition of some exemplar of UITableViewCell:

```swift
import UIKit
import PerseusDarkMode

class MemberTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()

        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))
        if AppearanceService.isEnabled { makeUp() }
    }

    private func configure() { }

    @objc private func makeUp() {
        // Point to define a reaction to Dark Mode event is here
        backgroundColor = .systemGray
    }
}
```

# License <a name="license"></a>
MIT License

Copyright (c) 2022 Mikhail Zhigulin of Novosibirsk

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
