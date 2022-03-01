import XCTest
@testable import PerseusDarkMode

final class DarkModeTests: XCTestCase
{
    func testInit()
    {
        XCTAssertFalse(AppearanceService.shared.isEnabled)
    }
}
