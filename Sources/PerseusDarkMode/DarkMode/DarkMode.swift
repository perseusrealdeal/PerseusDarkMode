import UIKit

public class DarkMode
{
    // MARK: - Dark Mode Style
    
    public var isEnabled         : Bool = false { willSet { if newValue == false { return } } }
    
    // MARK: - Dark Mode Style saved in UserDafaults
    
    public var userDefaults      : UserDefaults?
}
