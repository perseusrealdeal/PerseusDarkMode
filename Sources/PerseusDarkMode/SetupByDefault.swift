import UIKit

public extension UIViewController { var DarkMode: DarkMode { AppearanceService.shared } }
public extension UIView { var DarkMode: DarkMode { AppearanceService.shared } }

public class UIWindowAdoptable: UIWindow
{
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)
    {
        guard
            #available(iOS 13.0, *),
            let previousSystemStyle = previousTraitCollection?.userInterfaceStyle,
            previousSystemStyle.rawValue != DarkModeDecision.calculateSystemStyle().rawValue
        else { return }
        
        AppearanceService.adoptToDarkMode()
    }
}

// Local helpers

extension UserDefaults
{
    func valueExists(forKey key: String) -> Bool
    {
        return object(forKey: key) != nil
    }
}

