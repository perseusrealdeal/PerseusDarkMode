Perseus Dark Mode && Adapted System UI
======================================

[![License](http://img.shields.io/:LICENSE-MIT-blue.svg?style=plastic)](http://doge.mit-license.org)
![Platform](https://img.shields.io/badge/Platforms-iOS%209.0-orange.svg?style=plastic)
![Swift 5.3](https://img.shields.io/badge/Swift-5.3-red.svg?style=plastic)
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

---

### Adapted system colors <a name="subSection1"></a>

---

| RGBA Light          | RGBA Dark          | `Name`             | UIKit API Adapted     |
| :------------------ | :----------------- |:------------------ | :-------------------- |
| `System`                                                                              |
| 255, 59, 48, 1      | 255, 69, 58, 1     | `System red`       | .systemRed_Adapted    |
| 255, 149, 0, 1      | 255, 159, 10, 1    | `System orange`    | .systemOrange_Adapted |
| 255, 204, 0, 1      | 255, 214, 10, 1    | `System yellow`    | .systemYellow_Adapted |
| 52, 199, 89, 1      | 48, 209, 88, 1     | `System green`     | .systemGreen_Adapted  |
| 0, 199, 190, 1      | 102, 212, 207, 1   | `System mint`      | .systemMint_Adapted   |
| 48, 176, 199, 1     | 64, 200, 224, 1    | `System teal`      | .systemTeal_Adapted   |
| 50, 173, 230, 1     | 100, 210, 255, 1   | `System cyan`      | .systemCyan_Adapted   |
| 0, 122, 255, 1      | 10, 132, 255, 1    | `System blue`      | .systemBlue_Adapted   |
| 88, 86, 214, 1      | 94, 92, 230, 1     | `System indigo`    | .systemIndigo_Adapted |
| 175, 82, 222, 1     | 191, 90, 242, 1    | `System purple`    | .systemPurple_Adapted |
| 255, 45, 85, 1      | 255, 55, 95, 1     | `System pink`      | .systemPink_Adapted   |
| 162, 132, 94, 1     | 172, 142, 104, 1   | `System brown`     | .systemBrown_Adapted  |
| 142, 142, 147, 1    | 42, 142, 147, 1    | `System gray`      | .systemGray_Adapted   |
| 174, 174, 178, 1    | 99, 99, 102, 1     | `System gray 2`    | .systemGray2_Adapted  |
| 199, 199, 204, 1    | 72, 72, 74, 1      | `System gray 3`    | .systemGray3_Adapted  |
| 209, 209, 214, 1    | 58, 58, 60, 1      | `System gray 4`    | .systemGray4_Adapted  |
| 229, 229, 234, 1    | 44, 44, 46, 1      | `System gray 5`    | .systemGray5_Adapted  |
| 242, 242, 247, 1    | 28, 28, 30, 1      | `System gray 6`    | .systemGray6_Adapted  |

---

### Adapted semantic colors <a name="subSection2"></a>

---

| RGBA Light          | RGBA Dark          | `Name`             | UIKit API Adapted |
| :------------------ | :----------------- |:------------------ | :---------------  |
| **Foreground**                                                            |
| `Label`                                                                           |
| 255, 255, 255, 1    | 0, 0, 0, 1         | `Label`            | .label_Adapted    |
| 235, 235, 245, 0.6  | 60, 60, 67, 0.6    | `Secondary label`  | .secondaryLabel_Adapted  |
| 235, 235, 245, 0.3  | 60, 60, 67, 0.3    | `Tertiary label`   | .tertiaryLabel_Adapted   |
| 235, 235, 245, 0.18 | 60, 60, 67, 0.18   | `Quaternary label` | .quaternaryLabel_Adapted |
| `Text`                                                                                   |
| 235, 235, 245, 0.3  | 60, 60, 67, 0.3    | `Placeholder Text` | .placeholderText_Adapted |
| `Separator`                                                                              |
| 84, 84, 88, 0.6     | 60, 60, 67, 0.29   | `Separator`        | .separator_Adapted       |
| 56, 56, 58, 1       | 198, 198, 200, 1   | `Opaque separator` | .opaqueSeparator_Adapted |
| `Link`                                                                                   |
| 9, 132, 255, 1      | 0, 122, 255, 1     | `Link`             | .link_Adapted            |
| `Fill`                                                                                               |
| 120, 120, 128, 0.36 | 120, 120, 128, 0.2  | `System fill`            | .systemFill_Adapted           |
| 120, 120, 128, 0.32 | 120, 120, 128, 0.16 | `Secondary system fill`  | .secondarySystemFill_Adapted  |
| 118, 118, 128, 0.24 | 118, 118, 128, 0.12 | `Tertiary system fill`   | .tertiarySystemFill_Adapted   |
| 118, 118, 128, 0.18 | 116, 116, 128, 0.08 | `Quaternary system fill` | .quaternarySystemFill_Adapted |
| **Background**                                                                                               |
| `Standard`                                                                                                           |
| 0, 0, 0, 1    | 255, 255, 255, 1 | `System background`           | .systemBackground_Adapted                         |
| 28, 28, 30, 1 | 242, 242, 247, 1 | `Secondary system background` | .secondarySystemBackground_Adapted                |
| 44, 44, 46, 1 | 255, 255, 255, 1 | `Tertiary system background`  | .tertiarySystemBackground_Adapted                 |
| `Grouped`                                                                                                            |
| 0, 0, 0, 1    | 242, 242, 247, 1 | `System grouped background`           | .systemGroupedBackground_Adapted          |
| 28, 28, 30, 1 | 255, 255, 255, 1 | `Secondary system grouped background` | .secondarySystemGroupedBackground_Adapted |
| 44, 44, 46, 1 | 242, 242, 247, 1 | `Tertiary system grouped background`  | .tertiarySystemGroupedBackground_Adapted  |