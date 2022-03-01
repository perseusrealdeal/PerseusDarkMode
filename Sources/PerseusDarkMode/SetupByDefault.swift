import UIKit

public class AppearanceService
{
    public static var shared: DarkMode =
        {
            let instance = DarkMode()
            
            // Additional setup after initialisation.
            
            instance.userDefaults = UserDefaults.standard
            
            return instance
        }()
    
    private init() { }
}
