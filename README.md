Perseus Dark Mode && Adapted System UI
======================================

[![Actions Status](https://github.com/perseusrealdeal/DarkMode/actions/workflows/CI.yml/badge.svg)](https://github.com/perseusrealdeal/DarkMode/actions)
[![License](http://img.shields.io/:LICENSE-MIT-blue.svg?style=plastic)](http://doge.mit-license.org)
![Platform](https://img.shields.io/badge/Platforms-iOS%209.0-orange.svg?style=plastic)
![Swift 5.3](https://img.shields.io/badge/Swift-5.3-red.svg?style=plastic)
![SDK](https://img.shields.io/badge/SDK-UIKit%20-green.svg?style=plastic)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-informational.svg?style=plastic)](https://github.com/apple/swift-package-manager)

# Table of contents

1. [Prerequisites](#prerequisites)
2. [Solution key statements](#section1)
3. [Dark Mode table decision](#section2)
4. [Switching Dark Mode](#section3)
5. [Catching Dark Mode triggered](#section4)
6. [Sample Use Case of Dark Mode](#section5)
7. [Sample Use Case of Adapted System UI](#section6)
8. [List of Adapted Colors](#section7)
    1. [Adapted system colors](#subSection1)
    2. [Adapted semantic colors](#subSection2)
---

## Prerequisites <a name="prerequisites"></a>

Perseus Dark Mode is a swift package. Starting with iOS 13 Apple corp. introduced Dark Mode on system level and now all apps are sensitive to this user option.

Represented solution was designed to support your apps running on such brilliant apple devices like, you know, my favorite one and my the first one is iPod Touch iOS 9.3.5 (5th, 13G36).

Using this solution allows you design the code of your app applying the Apple's Dark Mode for your early Apple devices with no need make any changes then.

This package consists of two libraries. Main is Perseus Dark Mode and satellite one is Adapted System UI.

## Solution key statements <a name="section1"></a>

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

## Dark Mode table decision <a name="section2"></a>

`Dark Mode option values`

```swift
public enum DarkModeOption: Int, CustomStringConvertible
{
    case auto = 0
    case on = 1
    case off = 2

    /// ... other code
}
```

`Dark Mode System values`

```swift
public enum SystemStyle: Int
{
    case unspecified = 0
    case light = 1
    case dark = 2
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

## Switching Dark Mode <a name="section3"></a>

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
        guard #available(iOS 13.0, *) else { return }
        
        AppearanceService.overrideUserInterfaceStyleIfNeeded()
        
        guard let previousSystemStyle = previousTraitCollection?.userInterfaceStyle,
              previousSystemStyle.rawValue != DarkMode.SystemStyle.rawValue
        else { return }
        
        AppearanceService.makeUp()
    }
}

```

## Catching Dark Mode triggered <a name="section4"></a>

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

## Sample Use Case of Dark Mode <a name="section5"></a>

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

## Sample Use Case of Adapted System UI <a name="section6"></a>

```swift
import AdaptedSystemUI

let view = UIView()
view.backgroundColor = .systemBlue_Adapted
```

## List of Adapted Colors <a name="section7"></a>

### Adapted system colors <a name="subSection1"></a>

---

Origin system colors like MINT, CYAN, and BROWN are not released in SDK but presented in the official specification [here](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/)

| RGBA Light       | RGBA Dark        | UIKit API Adapted     | Light             | Dark              |
| :----------------| :--------------- | :-------------------- | :---------------: | :---------------: |
| 255, 59, 48, 1   | 255, 69, 58, 1   | .systemRed_Adapted    | ![#FF3B30FF](https://via.placeholder.com/50/FF3B30FF/000000?text=+) | ![#FF453AFF](https://via.placeholder.com/50/FF453AFF/000000?text=+) |
| 255, 149, 0, 1   | 255, 159, 10, 1  | .systemOrange_Adapted | ![#FF9500FF](https://via.placeholder.com/50/FF9500FF/000000?text=+) | ![#FF9F0AFF](https://via.placeholder.com/50/FF9F0AFF/000000?text=+) |
| 255, 204, 0, 1   | 255, 214, 10, 1  | .systemYellow_Adapted | ![#FFCC00FF](https://via.placeholder.com/50/FFCC00FF/000000?text=+) | ![#FFD60AFF](https://via.placeholder.com/50/FFD60AFF/000000?text=+) |
| 52, 199, 89, 1   | 48, 209, 88, 1   | .systemGreen_Adapted  | ![#34C759FF](https://via.placeholder.com/50/34C759FF/000000?text=+) | ![#30D158FF](https://via.placeholder.com/50/30D158FF/000000?text=+) |
| 0, 199, 190, 1   | 102, 212, 207, 1 | .systemMint_Adapted   | ![#00C7BEFF](https://via.placeholder.com/50/00C7BEFF/000000?text=+) | ![#66D4CFFF](https://via.placeholder.com/50/66D4CFFF/000000?text=+) |
| 48, 176, 199, 1  | 64, 200, 224, 1  | .systemTeal_Adapted   | ![#30B0C7FF](https://via.placeholder.com/50/30B0C7FF/000000?text=+) | ![#40C8E0FF](https://via.placeholder.com/50/40C8E0FF/000000?text=+) |
| 50, 173, 230, 1  | 100, 210, 255, 1 | .systemCyan_Adapted   | ![#32ADE6FF](https://via.placeholder.com/50/32ADE6FF/000000?text=+) | ![#64D2FFFF](https://via.placeholder.com/50/64D2FFFF/000000?text=+) |
| 0, 122, 255, 1   | 10, 132, 255, 1  | .systemBlue_Adapted   | ![#007AFFFF](https://via.placeholder.com/50/007AFFFF/000000?text=+) | ![#0A84FFFF](https://via.placeholder.com/50/0A84FFFF/000000?text=+) |
| 88, 86, 214, 1   | 94, 92, 230, 1   | .systemIndigo_Adapted | ![#5856D6FF](https://via.placeholder.com/50/5856D6FF/000000?text=+) | ![#5E5CE6FF](https://via.placeholder.com/50/5E5CE6FF/000000?text=+) |
| 175, 82, 222, 1  | 191, 90, 242, 1  | .systemPurple_Adapted | ![#AF52DEFF](https://via.placeholder.com/50/AF52DEFF/000000?text=+) | ![#BF5AF2FF](https://via.placeholder.com/50/BF5AF2FF/000000?text=+) |
| 255, 45, 85, 1   | 255, 55, 95, 1   | .systemPink_Adapted   | ![#FF2D55FF](https://via.placeholder.com/50/FF2D55FF/000000?text=+) | ![#FF375FFF](https://via.placeholder.com/50/FF375FFF/000000?text=+) |
| 162, 132, 94, 1  | 172, 142, 104, 1 | .systemBrown_Adapted  | ![#A2845EFF](https://via.placeholder.com/50/A2845EFF/000000?text=+) | ![#AC8E68FF](https://via.placeholder.com/50/AC8E68FF/000000?text=+) |
| 142, 142, 147, 1 | 142, 142, 147, 1 | .systemGray_Adapted   | ![#8E8E93FF](https://via.placeholder.com/50/8E8E93FF/000000?text=+) | ![#8E8E93FF](https://via.placeholder.com/50/8E8E93FF/000000?text=+) |
| 174, 174, 178, 1 | 99, 99, 102, 1   | .systemGray2_Adapted  | ![#AEAEB2FF](https://via.placeholder.com/50/AEAEB2FF/000000?text=+) | ![#636366FF](https://via.placeholder.com/50/636366FF/000000?text=+) |
| 199, 199, 204, 1 | 72, 72, 74, 1    | .systemGray3_Adapted  | ![#C7C7CCFF](https://via.placeholder.com/50/C7C7CCFF/000000?text=+) | ![#48484AFF](https://via.placeholder.com/50/48484AFF/000000?text=+) |
| 209, 209, 214, 1 | 58, 58, 60, 1    | .systemGray4_Adapted  | ![#D1D1D6FF](https://via.placeholder.com/50/D1D1D6FF/000000?text=+) | ![#3A3A3CFF](https://via.placeholder.com/50/3A3A3CFF/000000?text=+) |
| 229, 229, 234, 1 | 44, 44, 46, 1    | .systemGray5_Adapted  | ![#E5E5EAFF](https://via.placeholder.com/50/E5E5EAFF/000000?text=+) | ![#2C2C2EFF](https://via.placeholder.com/50/2C2C2EFF/000000?text=+) |
| 242, 242, 247, 1 | 28, 28, 30, 1    | .systemGray6_Adapted  | ![#F2F2F7FF](https://via.placeholder.com/50/F2F2F7FF/000000?text=+) | ![#1C1C1EFF](https://via.placeholder.com/50/1C1C1EFF/000000?text=+) |

---

### Adapted semantic colors <a name="subSection2"></a>

---

| RGBA Light          | RGBA Dark          | UIKit API Adapted | Light             | Dark              |
| :------------------ | :----------------- | :---------------  | :---------------: | :---------------: |
| **Foreground**                                               |
| `Label`                                                      |
| 255, 255, 255, 1    | 0, 0, 0, 1         | .label_Adapted    | ![#FFFFFFFF](https://via.placeholder.com/50/FFFFFFFF/000000?text=+) | ![#000000FF](https://via.placeholder.com/50/000000FF/000000?text=+) |
| 235, 235, 245, 0.6  | 60, 60, 67, 0.6    | .secondaryLabel_Adapted  | ![#EBEBF599](https://via.placeholder.com/50/EBEBF599/000000?text=+) | ![#3C3C4399](https://via.placeholder.com/50/3C3C4399/000000?text=+) |
| 235, 235, 245, 0.3  | 60, 60, 67, 0.3    | .tertiaryLabel_Adapted   | ![#EBEBF54D](https://via.placeholder.com/50/EBEBF54D/000000?text=+) | ![#3C3C434D](https://via.placeholder.com/50/3C3C434D/000000?text=+) |
| 235, 235, 245, 0.18 | 60, 60, 67, 0.18   | .quaternaryLabel_Adapted | ![#EBEBF52E](https://via.placeholder.com/50/EBEBF52E/000000?text=+) | ![#3C3C432E](https://via.placeholder.com/50/3C3C432E/000000?text=+) |
| `Text`                                                              |
| 235, 235, 245, 0.3  | 60, 60, 67, 0.3    | .placeholderText_Adapted | ![#EBEBF54D](https://via.placeholder.com/50/EBEBF54D/000000?text=+) | ![#3C3C434D](https://via.placeholder.com/50/3C3C434D/000000?text=+) |
| `Separator`                                                         |
| 84, 84, 88, 0.6     | 60, 60, 67, 0.29   | .separator_Adapted       | ![#54545899](https://via.placeholder.com/50/54545899/000000?text=+) | ![#3C3C434A](https://via.placeholder.com/50/3C3C434A/000000?text=+) |
| 56, 56, 58, 1       | 198, 198, 200, 1   | .opaqueSeparator_Adapted | ![#38383AFF](https://via.placeholder.com/50/38383AFF/000000?text=+) | ![#C6C6C8FF](https://via.placeholder.com/50/C6C6C8FF/000000?text=+) |
| `Link`                                                              |
| 9, 132, 255, 1      | 0, 122, 255, 1     | .link_Adapted            | ![#0984FFFF](https://via.placeholder.com/50/0984FFFF/000000?text=+) | ![#007AFFFF](https://via.placeholder.com/50/007AFFFF/000000?text=+) |
| `Fill`                                                                    |
| 120, 120, 128, 0.36 | 120, 120, 128, 0.2  | .systemFill_Adapted           | ![#7878805C](https://via.placeholder.com/50/7878805C/000000?text=+) | ![#78788033](https://via.placeholder.com/50/78788033/000000?text=+) |
| 120, 120, 128, 0.32 | 120, 120, 128, 0.16 | .secondarySystemFill_Adapted  | ![#78788052](https://via.placeholder.com/50/78788052/000000?text=+) | ![#78788029](https://via.placeholder.com/50/78788029/000000?text=+) |
| 118, 118, 128, 0.24 | 118, 118, 128, 0.12 | .tertiarySystemFill_Adapted   | ![#7676803D](https://via.placeholder.com/50/7676803D/000000?text=+) | ![#7676801F](https://via.placeholder.com/50/7676801F/000000?text=+) |
| 118, 118, 128, 0.18 | 116, 116, 128, 0.08 | .quaternarySystemFill_Adapted | ![#7676802E](https://via.placeholder.com/50/7676802E/000000?text=+) | ![#74748014](https://via.placeholder.com/50/74748014/000000?text=+) |
| **Background**                                                               |
| `Standard`                                                                   |
| 0, 0, 0, 1    | 255, 255, 255, 1 | .systemBackground_Adapted                 | ![#000000FF](https://via.placeholder.com/50/000000FF/000000?text=+) | ![#FFFFFFFF](https://via.placeholder.com/50/FFFFFFFF/000000?text=+) |
| 28, 28, 30, 1 | 242, 242, 247, 1 | .secondarySystemBackground_Adapted        | ![#1C1C1EFF](https://via.placeholder.com/50/1C1C1EFF/000000?text=+) | ![#F2F2F7FF](https://via.placeholder.com/50/F2F2F7FF/000000?text=+) |
| 44, 44, 46, 1 | 255, 255, 255, 1 | .tertiarySystemBackground_Adapted         | ![#2C2C2EFF](https://via.placeholder.com/50/2C2C2EFF/000000?text=+) | ![#FFFFFFFF](https://via.placeholder.com/50/FFFFFFFF/000000?text=+) |
| `Grouped`                                                                    |
| 0, 0, 0, 1    | 242, 242, 247, 1 | .systemGroupedBackground_Adapted          | ![#000000FF](https://via.placeholder.com/50/000000FF/000000?text=+) | ![#F2F2F7FF](https://via.placeholder.com/50/F2F2F7FF/000000?text=+) |
| 28, 28, 30, 1 | 255, 255, 255, 1 | .secondarySystemGroupedBackground_Adapted | ![#1C1C1EFF](https://via.placeholder.com/50/1C1C1EFF/000000?text=+) | ![#FFFFFFFF](https://via.placeholder.com/50/FFFFFFFF/000000?text=+) |
| 44, 44, 46, 1 | 242, 242, 247, 1 | .tertiarySystemGroupedBackground_Adapted  | ![#2C2C2EFF](https://via.placeholder.com/50/2C2C2EFF/000000?text=+) | ![#F2F2F7FF](https://via.placeholder.com/50/F2F2F7FF/000000?text=+) |

