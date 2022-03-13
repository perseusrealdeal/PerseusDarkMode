Perseus Dark Mode
=================

[![License](http://img.shields.io/:LICENSE-MIT-blue.svg?style=plastic)](http://doge.mit-license.org)
![Platform](https://img.shields.io/badge/Platforms-iOS%209.0-orange.svg?style=plastic)
![Swift 5.3](https://img.shields.io/badge/Swift-5.3-red.svg?style=plastic)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-informational.svg?style=plastic)](https://github.com/apple/swift-package-manager)

Prerequisites
-------------

Perseus Dark Mode is a swift package. With iOS 13 Apple corp. introduced Dark Mode on system level and now all apps are sensitive to this user option.

The solution was designed to support your apps running on such brilliant apple devices like, you know, my favorite one and the first one is iPod Touch iOS 9.3.5 (5th, 13G36).

Using this solution allow you design the code of your app applying the Apple's Dark Mode for your early Apple devices with no need make any changes then.

Solution key statements
-----------------------

`Dark Mode is a Singleton object`

```swift
public static var shared: DarkMode = { DarkMode() } ()
private init() { }
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

`Dark Mode is served as a property`

```swift
public extension UIResponder { var DarkMode: DarkModeProtocol { AppearanceService.shared } }
```