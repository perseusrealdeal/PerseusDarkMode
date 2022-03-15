Perseus Dark Mode && Adapted System UI
======================================

[![License](http://img.shields.io/:LICENSE-MIT-blue.svg?style=plastic)](http://doge.mit-license.org)
![Platform](https://img.shields.io/badge/Platforms-iOS%209.0-orange.svg?style=plastic)
![Swift 5.3](https://img.shields.io/badge/Swift-5.3-red.svg?style=plastic)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-informational.svg?style=plastic)](https://github.com/apple/swift-package-manager)

Prerequisites
-------------

Perseus Dark Mode is a swift package. With iOS 13 Apple corp. introduced Dark Mode on system level and now all apps are sensitive to this user option.

Solution was designed to support your apps running on such brilliant apple devices like, you know, my favorite one and my the first one is iPod Touch iOS 9.3.5 (5th, 13G36).

Using this solution allows you design the code of your app applying the Apple's Dark Mode for your early Apple devices with no need make any changes then.

This package consists of two libraries. Main is Perseus Dark Mode and satellite one is Adapted System UI.

Solution key statements
-----------------------

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

Switching Dark Mode
-------------------

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

Catching Dark Mode triggered
----------------------------

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

Using Adapted System UI
-----------------------

```swift
import AdaptedSystemUI

let view = UIView()
view.backgroundColor = .systemBlue_Adapted
```

Sample Use Case
---------------

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

Sample Use Case Addition
------------------------

If your view or view controller is declared as lazy one or a sub view like UITableViewCell it's not bad to add the following condition after registering.

```swift
if AppearanceService.isEnabled { makeUp() }
```

For instance, definition of some exemplar of UITableViewCell

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