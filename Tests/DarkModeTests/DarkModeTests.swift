import XCTest
@testable import PerseusDarkMode
@testable import AdoptedSystemUI

final class DarkModeTests: XCTestCase
{
    func testInit()
    {
        XCTAssertFalse(AppearanceService.shared.isEnabled)
        
    }
}
