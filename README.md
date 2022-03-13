Perseus Dark Mode
=================

[![License](http://img.shields.io/:LICENSE-MIT-blue.svg?style=plastic)](http://doge.mit-license.org)
![Platform](https://img.shields.io/badge/Platforms-iOS%209.0-orange.svg?style=plastic)
![Swift 5.3](https://img.shields.io/badge/Swift-5.3-red.svg?style=plastic)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-informational.svg?style=plastic)](https://github.com/apple/swift-package-manager)

Prerequisites
-------------

Perseus Dark Mode is a swift package. With iOS 13 Apple corp. introduced Dark Mode on system level and now all apps are sensitive to this user option.

Solution was designed to support your apps running on such brilliant apple devices like, you know, my favorite one and my the first one is iPod Touch iOS 9.3.5 (5th, 13G36).

Using this solution allow you design the code of your app applying the Apple's Dark Mode for your early Apple devices with no need make any changes then.

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

There is only one way to let it know that you'd like to change Dark Mode inside your app.

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

Each time when system calls traitCollectionDidChange method, it happens if user taggled Dark Mode in Settings app, Dark Mode recalculated automatically.

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

```swift

```

`Case: Getting informed by NotificationCenter`

```swift

```
