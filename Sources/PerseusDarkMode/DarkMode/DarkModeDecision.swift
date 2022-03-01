import UIKit

// MARK: - Calculations

public class DarkModeDecision
{
    // MARK: - Private init
    
    private init() { }
    
    // MARK: - Calculating Dark Mode decision
    
    /// Decision table for Actual Style
    ///
    /// — — — — — — — — — — — — — — DarkModeOption — — — — —
    /// — — — — — — — — — — — — auto — — — on — — — — off  — —
    /// — — — — — — — — — — — — — — — — — — — — — — — — —
    /// System style  .unspecified            default            dark              light
    /// System style  .light                         light               dark              light
    /// System style  .dark                         dark              dark              light
    /// — — — — — — — — — — — — — — — — — — — — — — — — —
    ///
    public class func calculateActualStyle(_ userChoice: DarkModeOption) -> AppearanceStyle
    {
        // Inputs
        
        let userChoice = userChoice
        let systemStyle = calculateSystemStyle()
        
        // Calculate outputs
        
        if (systemStyle == .unspecified) && (userChoice == .auto)
        {
            return DARK_MODE_STYLE_DEFAULT
        }
        if (systemStyle == .unspecified) && (userChoice == .on) { return .dark}
        if (systemStyle == .unspecified) && (userChoice == .off) { return .light}
        
        if (systemStyle == .light) && (userChoice == .auto) { return .light }
        if (systemStyle == .light) && (userChoice == .on) { return .dark}
        if (systemStyle == .light) && (userChoice == .off) { return .light}
        
        if (systemStyle == .dark) && (userChoice == .auto) { return .dark }
        if (systemStyle == .dark) && (userChoice == .on) { return .dark}
        if (systemStyle == .dark) && (userChoice == .off) { return .light}
        
        // Output default value if somethings goes out of the decision table
        
        return DARK_MODE_STYLE_DEFAULT
    }
    
    public class func calculateSystemStyle() -> SystemStyle
    {
        if #available(iOS 13.0, *)
        {
            guard let keyWindow = UIApplication.shared.keyWindow else { return .unspecified }
            
            switch keyWindow.traitCollection.userInterfaceStyle
            {
            case .unspecified:
                return .unspecified
            case .light:
                return .light
            case .dark:
                return .dark
                
            @unknown default:
                return .unspecified
            }
        }
        else
        {
            return .unspecified
        }
    }
}
