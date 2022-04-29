Perseus Dark Mode && Adapted System UI
======================================

[![Actions Status](https://github.com/perseusrealdeal/DarkMode/actions/workflows/CI.yml/badge.svg)](https://github.com/perseusrealdeal/DarkMode/actions)
[![License](http://img.shields.io/:LICENSE-MIT-blue.svg)](http://doge.mit-license.org)
![Platform](https://img.shields.io/badge/Platforms-iOS%209.0-orange.svg)
![Swift 5.3](https://img.shields.io/badge/Swift-5.3-red.svg)
![SDK](https://img.shields.io/badge/SDK-UIKit%20-blueviolet.svg)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-informational.svg)](https://github.com/apple/swift-package-manager)

Have a look of demo app, source code is [here](https://github.com/perseusrealdeal/ios.darkmode.discovery.git).

# Table of contents

PART I - [Perseus Dark Mode Library](#part_I)

[Introductory remarks](#section1)
1. [Build tools](#section2)
2. [Solution key statements](#section3)
3. [Dark Mode table decision](#section4)
4. [Switching Dark Mode](#section5)
5. [Catching Dark Mode triggered](#section6)
6. [Sample Use Case of Dark Mode](#section7)
7. [Sample Use Case of Adapted System UI](#section8)

PART II - [Adapted System UI Library](#part_II)

[Introductory remarks](#section1_II)
1. [Table 1. Adapted system colors](#subSection1)
2. [Table 2. Adapted semantic colors](#subSection2)

[License](#license)

---

# PART I - Perseus Dark Mode Library <a name="part_I"></a>

## Introductory remarks <a name="section1"></a>

Perseus Dark Mode is a swift package. Starting with iOS 13 Apple Inc. introduced Dark Mode on system level and now all apps are sensitive to this user option.

Represented solution was designed to support your apps running on such brilliant apple devices like, you know, my favorite one and my the first one is iPod Touch iOS 9.3.5 (5th, 13G36).

Using this solution allows you design the code of your app applying the Apple's Dark Mode for your early Apple devices with no need make any changes then.

This package consists of two libraries. Main is Perseus Dark Mode and satellite one is Adapted System UI.

## 1. Build tools <a name="section2"></a>

Tools used for designing the solution:
+ Xcode 12.5
+ Device iPod Touch iOS 9.3.5 (5th, 13G36) 
+ Simulator iPhone 5s (iOS 11.4, 15F79) 
+ Simulator iPhone 8 (iOS 13.7, 17H22)
+ Simulator iPhone 12 mini (iOS 14.5, 18E182)

## 2. Solution key statements <a name="section3"></a>

`Dark Mode is a Singleton object`

```swift
public class AppearanceService
{
    public static var shared: DarkMode = { DarkMode() } ()
    private init() { }

    /// ... other code
}
```

`Dark Mode is a complex object`

```swift
public protocol DarkModeProtocol
{
    var Style                  : AppearanceStyle { get }
    var SystemStyle            : SystemStyle { get }
    
    dynamic var StyleObservable: Int { get }
}

extension DarkMode: DarkModeProtocol { }
```

`Dark Mode is hosted as a property`

```swift
public extension UIResponder { var DarkMode: DarkModeProtocol { AppearanceService.shared } }
```

## 3. Dark Mode table decision <a name="section4"></a>

`Dark Mode option values`

```swift
public enum DarkModeOption: Int
{
    case auto = 0
    case on   = 1
    case off  = 2
}
```

`Dark Mode System values`

```swift
public enum SystemStyle: Int
{
    case unspecified = 0
    case light       = 1
    case dark        = 2
}
```

`Dark Mode decision table`

Dark Mode default value is light.

```swift
public let DARK_MODE_STYLE_DEFAULT = AppearanceStyle.light
```

|                  | auto      | on   | off   |
| ---------------- | :-------: |:----:| :----:|
| **.unspecified** | default   | dark | light |
| **.light**       | light     | dark | light |
| **.dark**        | dark      | dark | light |

In case if dark mode is auto and system style is .unspecified, default value is applied for iOS 12 and eariler, but, for iOS 13 and higher, device system appearance mode is applied.

`Appearance style`

Dark Mode decision table makes decision on Appearance style that can be either light or dark.

```swift
public enum AppearanceStyle: Int
{
    case light = 0
    case dark  = 1
}
```

Apps that are based on Perseus Dark Mode rely on AppearanceStyle as a business matter value available for accessing via UIResponder extension.

```swift
import UIKit
import PerseusDarkMode

class MyView: UIView 
{ 
    func functionName() 
    { 
        print("\(self.DarkMode.Style)")
    } 
}
```

## 4. Switching Dark Mode <a name="section5"></a>

`Case: Manually`

Inside your app there is only one way to let it know that you'd like to change Dark Mode.

Use DarkModeUserChoice hosted as a property in AppearanceService to assign the value of Dark Mode you want.

```swift
public class AppearanceService
{
    public static var DarkModeUserChoice: DarkModeOption

    /// ... other code
}
```

So, in your code it should look like this

```swift
let choice = DarkModeOption.auto

AppearanceService.DarkModeUserChoice = choice

AppearanceService.makeUp()
```

And do not forget call makeUp() if you want to be notified via NotificationCenter.

`Case: Via System`

Each time when system calls traitCollectionDidChange method, it happens if user taggled Dark Mode in Settings app, Dark Mode is recalculated automatically.

```swift
public class UIWindowAdaptable: UIWindow
{
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)
    {
        if AppearanceService._changeManually { return }
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard #available(iOS 13.0, *),
              let previousSystemStyle = previousTraitCollection?.userInterfaceStyle,
              previousSystemStyle.rawValue != DarkMode.SystemStyle.rawValue
        else { return }
        
        AppearanceService._systemCalledMakeUp()
    }
}
```

## 5. Catching Dark Mode triggered <a name="section6"></a>

`Case: Using KVO`

Create an observer somewhere in your code like this

```swift
 var observer:DarkModeObserver? = DarkModeObserver(AppearanceService.shared)
```

Then, give it a closure to run your code if Dark Mode changed

```swift
observer?.action = 
    { newStyle in 
        
        /// Start define your reaction on Dark Mode changed from here

    }
```

`Case: Getting informed by NotificationCenter`

To get notified by NotificationCenter your object should be registered with AppearanceService

```swift
import UIKit

class MyView: UIView 
{ 
    @objc func makeUp() 
    { 
        /// Start define your reaction on Dark Mode changed from here
    } 
}
let view = MyView()

AppearanceService.register(observer: view, selector: #selector(view.makeUp))
```

Use AppearanceService.makeUp() to call all selected makeUp methods

```swift
AppearanceService.makeUp()
```

## 6. Sample Use Case of Dark Mode <a name="section7"></a>

Declare UIWindowAdaptable window to get system Dark Mode automatically

```swift
import UIKit
import PerseusDarkMode

class AppDelegate: UIResponder { var window: UIWindow? }

extension AppDelegate: UIApplicationDelegate
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindowAdaptable(frame: UIScreen.main.bounds)
        
        window!.rootViewController = MainViewController()
        window!.makeKeyAndVisible()
        
        AppearanceService.makeUp()
        
        return true
    }
}
```

Then, let AppearanceService know that you want take a control of Dark Mode

```swift
import UIKit
import PerseusDarkMode
import AdaptedSystemUI

class MainViewController: UIViewController
{
    let darkModeObserver = DarkModeObserver(AppearanceService.shared)
    
    override func viewDidLoad()
    {
       super.viewDidLoad()
        
        AppearanceService.register(observer: self, selector: #selector(makeUp))
        configure()

        darkModeObserver.action =
            { newStyle in

                /// Start define your reaction on Dark Mode changed from here
                print("\(newStyle), \(self.DarkMode.Style)")
            }
    }

    @objc private func makeUp()
    {
        /// Start define your reaction on Dark Mode changed from here
        view.backgroundColor = .systemRed_Adapted
    }

    private func configure() { }
}
```

`In addition to sample use case`

If your view or view controller is declared as lazy one or a sub view like UITableViewCell it's not bad to add the following condition after registering.

```swift
if AppearanceService.isEnabled { makeUp() }
```

For instance, here is a definition of some exemplar of UITableViewCell

```swift
import UIKit
import PerseusDarkMode
import AdaptedSystemUI

class MemberTableViewCell: UITableViewCell
{
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        AppearanceService.register(observer: self, selector: #selector(makeUp))
        configure()

        if AppearanceService.isEnabled { makeUp() }
    }

    private func configure() { }

    @objc private func makeUp()
    {
        backgroundColor = .systemGray_Adapted
    }
}
```

## 7. Sample Use Case of Adapted System UI <a name="section8"></a>

```swift
import AdaptedSystemUI

let view = UIView()
view.backgroundColor = .systemBlue_Adapted
```

In case if you ever need a certain color of a Dark Mode sensitive color use the line of code below.

```swift
let _ = UIColor.label_Adapted.resolvedColor(with: self.traitCollection).cgColor
```

# PART II - Adapted System UI Library <a name="part_II"></a>

## Introductory remarks <a name="section1_II"></a>

System colors MINT, CYAN, and BROWN are not released in SDK, but presented in the official specification [here](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/).

SDK (iOS 13.7) system color TEAL has a different value than that presented in the official specification.

Specification TEAL RGBA: 64, 200, 224 in Dark.

SDK (iOS 13.7) TEAL RGBA: 100, 210, 255 in Dark.

Adapted System UI library uses SDK version of TEAL color for sure.

## Table 1. Adapted system colors <a name="subSection1"></a>

| RGBA Light    | RGBA Dark     | UIKit API Adapted     | Light             | Dark              |
| :-------------| :------------ | :-------------------- | :---------------: | :---------------: |
| 255, 59, 48   | 255, 69, 58   | .systemRed_Adapted    | ![#FF3B30FF](https://via.placeholder.com/50/FF3B30FF/000000?text=+) | ![#FF453AFF](https://via.placeholder.com/50/FF453AFF/000000?text=+) |
| 255, 149, 0   | 255, 159, 10  | .systemOrange_Adapted | ![#FF9500FF](https://via.placeholder.com/50/FF9500FF/000000?text=+) | ![#FF9F0AFF](https://via.placeholder.com/50/FF9F0AFF/000000?text=+) |
| 255, 204, 0   | 255, 214, 10  | .systemYellow_Adapted | ![#FFCC00FF](https://via.placeholder.com/50/FFCC00FF/000000?text=+) | ![#FFD60AFF](https://via.placeholder.com/50/FFD60AFF/000000?text=+) |
| 52, 199, 89   | 48, 209, 88   | .systemGreen_Adapted  | ![#34C759FF](https://via.placeholder.com/50/34C759FF/000000?text=+) | ![#30D158FF](https://via.placeholder.com/50/30D158FF/000000?text=+) |
| 0, 199, 190   | 102, 212, 207 | .systemMint_Adapted   | ![#00C7BEFF](https://via.placeholder.com/50/00C7BEFF/000000?text=+) | ![#66D4CFFF](https://via.placeholder.com/50/66D4CFFF/000000?text=+) |
| 90, 200, 250  | 100, 210, 255 | .systemTeal_Adapted   | ![#5AC8FAFF](https://via.placeholder.com/50/5AC8FAFF/000000?text=+) | ![#64D2FFFF](https://via.placeholder.com/50/64D2FFFF/000000?text=+) |
| 50, 173, 230  | 100, 210, 255 | .systemCyan_Adapted   | ![#32ADE6FF](https://via.placeholder.com/50/32ADE6FF/000000?text=+) | ![#64D2FFFF](https://via.placeholder.com/50/64D2FFFF/000000?text=+) |
| 0, 122, 255   | 10, 132, 255  | .systemBlue_Adapted   | ![#007AFFFF](https://via.placeholder.com/50/007AFFFF/000000?text=+) | ![#0A84FFFF](https://via.placeholder.com/50/0A84FFFF/000000?text=+) |
| 88, 86, 214   | 94, 92, 230   | .systemIndigo_Adapted | ![#5856D6FF](https://via.placeholder.com/50/5856D6FF/000000?text=+) | ![#5E5CE6FF](https://via.placeholder.com/50/5E5CE6FF/000000?text=+) |
| 175, 82, 222  | 191, 90, 242  | .systemPurple_Adapted | ![#AF52DEFF](https://via.placeholder.com/50/AF52DEFF/000000?text=+) | ![#BF5AF2FF](https://via.placeholder.com/50/BF5AF2FF/000000?text=+) |
| 255, 45, 85   | 255, 55, 95   | .systemPink_Adapted   | ![#FF2D55FF](https://via.placeholder.com/50/FF2D55FF/000000?text=+) | ![#FF375FFF](https://via.placeholder.com/50/FF375FFF/000000?text=+) |
| 162, 132, 94  | 172, 142, 104 | .systemBrown_Adapted  | ![#A2845EFF](https://via.placeholder.com/50/A2845EFF/000000?text=+) | ![#AC8E68FF](https://via.placeholder.com/50/AC8E68FF/000000?text=+) |
| 142, 142, 147 | 142, 142, 147 | .systemGray_Adapted   | ![#8E8E93FF](https://via.placeholder.com/50/8E8E93FF/000000?text=+) | ![#8E8E93FF](https://via.placeholder.com/50/8E8E93FF/000000?text=+) |
| 174, 174, 178 | 99, 99, 102   | .systemGray2_Adapted  | ![#AEAEB2FF](https://via.placeholder.com/50/AEAEB2FF/000000?text=+) | ![#636366FF](https://via.placeholder.com/50/636366FF/000000?text=+) |
| 199, 199, 204 | 72, 72, 74    | .systemGray3_Adapted  | ![#C7C7CCFF](https://via.placeholder.com/50/C7C7CCFF/000000?text=+) | ![#48484AFF](https://via.placeholder.com/50/48484AFF/000000?text=+) |
| 209, 209, 214 | 58, 58, 60    | .systemGray4_Adapted  | ![#D1D1D6FF](https://via.placeholder.com/50/D1D1D6FF/000000?text=+) | ![#3A3A3CFF](https://via.placeholder.com/50/3A3A3CFF/000000?text=+) |
| 229, 229, 234 | 44, 44, 46    | .systemGray5_Adapted  | ![#E5E5EAFF](https://via.placeholder.com/50/E5E5EAFF/000000?text=+) | ![#2C2C2EFF](https://via.placeholder.com/50/2C2C2EFF/000000?text=+) |
| 242, 242, 247 | 28, 28, 30    | .systemGray6_Adapted  | ![#F2F2F7FF](https://via.placeholder.com/50/F2F2F7FF/000000?text=+) | ![#1C1C1EFF](https://via.placeholder.com/50/1C1C1EFF/000000?text=+) |

## Table 2. Adapted semantic colors <a name="subSection2"></a>

| RGBA Light        | RGBA Dark           | UIKit API Adapted | Light             | Dark              |
| :---------------- | :------------------ | :---------------  | :---------------: | :---------------: |
| **Foreground**                                              |
| `Label`                                                     |
| 0, 0, 0, 1        | 255, 255, 255, 1    | .label_Adapted    | ![#000000FF](https://via.placeholder.com/50/000000FF/000000?text=+) | ![#FFFFFFFF](https://via.placeholder.com/50/FFFFFFFF/000000?text=+) |
| 60, 60, 67, 0.6   | 235, 235, 245, 0.6  | .secondaryLabel_Adapted  | ![#3C3C4399](https://via.placeholder.com/50/3C3C4399/000000?text=+) | ![#EBEBF599](https://via.placeholder.com/50/EBEBF599/000000?text=+) |
| 60, 60, 67, 0.3   | 235, 235, 245, 0.3  | .tertiaryLabel_Adapted   | ![#3C3C434D](https://via.placeholder.com/50/3C3C434D/000000?text=+) | ![#EBEBF54D](https://via.placeholder.com/50/EBEBF54D/000000?text=+) |
| 60, 60, 67, 0.18  | 235, 235, 245, 0.18 | .quaternaryLabel_Adapted | ![#3C3C432E](https://via.placeholder.com/50/3C3C432E/000000?text=+) | ![#EBEBF52E](https://via.placeholder.com/50/EBEBF52E/000000?text=+) |
| `Text`                                                             |
| 60, 60, 67, 0.3   | 235, 235, 245, 0.3  | .placeholderText_Adapted | ![#3C3C434D](https://via.placeholder.com/50/3C3C434D/000000?text=+) | ![#EBEBF54D](https://via.placeholder.com/50/EBEBF54D/000000?text=+) |
| `Separator`                                                        |
| 60, 60, 67, 0.29  | 84, 84, 88, 0.6     | .separator_Adapted       | ![#3C3C434A](https://via.placeholder.com/50/3C3C434A/000000?text=+) | ![#54545899](https://via.placeholder.com/50/54545899/000000?text=+) |
| 198, 198, 200, 1  | 56, 56, 58, 1       | .opaqueSeparator_Adapted | ![#C6C6C8FF](https://via.placeholder.com/50/C6C6C8FF/000000?text=+) | ![#38383AFF](https://via.placeholder.com/50/38383AFF/000000?text=+) |
| `Link`                                                             |
| 0, 122, 255, 1    | 9, 132, 255, 1      | .link_Adapted            | ![#007AFFFF](https://via.placeholder.com/50/007AFFFF/000000?text=+) | ![#0984FFFF](https://via.placeholder.com/50/0984FFFF/000000?text=+) |
| `Fill`                                                                    |
| 120, 120, 128, 0.2  | 120, 120, 128, 0.36 | .systemFill_Adapted           | ![#78788033](https://via.placeholder.com/50/78788033/000000?text=+) | ![#7878805C](https://via.placeholder.com/50/7878805C/000000?text=+) |
| 120, 120, 128, 0.16 | 120, 120, 128, 0.32 | .secondarySystemFill_Adapted  | ![#78788029](https://via.placeholder.com/50/78788029/000000?text=+) | ![#78788052](https://via.placeholder.com/50/78788052/000000?text=+) |
| 118, 118, 128, 0.12 | 118, 118, 128, 0.24 | .tertiarySystemFill_Adapted   | ![#7676801F](https://via.placeholder.com/50/7676801F/000000?text=+) | ![#7676803D](https://via.placeholder.com/50/7676803D/000000?text=+) |
| 116, 116, 128, 0.08 | 118, 118, 128, 0.18 | .quaternarySystemFill_Adapted | ![#74748014](https://via.placeholder.com/50/74748014/000000?text=+) | ![#7676802E](https://via.placeholder.com/50/7676802E/000000?text=+) |
| **Background**                                                               |
| `Standard`                                                                   |
| 255, 255, 255, 1 | 28, 28, 30, 1    | .systemBackground_Adapted                 | ![#FFFFFFFF](https://via.placeholder.com/50/FFFFFFFF/000000?text=+) | ![#1C1C1EFF](https://via.placeholder.com/50/1C1C1EFF/000000?text=+) |
| 242, 242, 247, 1 | 44, 44, 46, 1 | .secondarySystemBackground_Adapted        | ![#F2F2F7FF](https://via.placeholder.com/50/F2F2F7FF/000000?text=+) | ![#2C2C2EFF](https://via.placeholder.com/50/2C2C2EFF/000000?text=+) |
| 255, 255, 255, 1 | 58, 58, 60, 1 | .tertiarySystemBackground_Adapted         | ![#FFFFFFFF](https://via.placeholder.com/50/FFFFFFFF/000000?text=+) | ![#3A3A3CFF](https://via.placeholder.com/50/3A3A3CFF/000000?text=+) |
| `Grouped`                                                                    |
| 242, 242, 247, 1 | 28, 28, 30, 1    | .systemGroupedBackground_Adapted          | ![#F2F2F7FF](https://via.placeholder.com/50/F2F2F7FF/000000?text=+) | ![#1C1C1EFF](https://via.placeholder.com/50/1C1C1EFF/000000?text=+) |
| 255, 255, 255, 1 | 44, 44, 46, 1 | .secondarySystemGroupedBackground_Adapted | ![#FFFFFFFF](https://via.placeholder.com/50/FFFFFFFF/000000?text=+) | ![#2C2C2EFF](https://via.placeholder.com/50/2C2C2EFF/000000?text=+) |
| 242, 242, 247, 1 | 58, 58, 60, 1 | .tertiarySystemGroupedBackground_Adapted  | ![#F2F2F7FF](https://via.placeholder.com/50/F2F2F7FF/000000?text=+) | ![#3A3A3CFF](https://via.placeholder.com/50/3A3A3CFF/000000?text=+) |

# License <a name="license"></a>

Copyright © 2022 Mikhail Zhigulin

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
