@testable import DJSystemiOS
import XCTest

final class UtilsTests: XCTestCase {

    func testFormatTime() throws {
        let formattedTime1 = Utils.formatTime(hours: 0, minutes: 45, seconds: 15)
        XCTAssertEqual(formattedTime1, "45:15")

        let formattedTime2 = Utils.formatTime(hours: 0, minutes: 45, seconds: 5)
        XCTAssertEqual(formattedTime2, "45:05")

        let formattedTime3 = Utils.formatTime(hours: 1, minutes: 30, seconds: 30)
        XCTAssertEqual(formattedTime3, "01:30:30")

        let formattedTime4 = Utils.formatTime(hours: 1, minutes: 0, seconds: 0)
        XCTAssertEqual(formattedTime4, "01:00:00")
    }
    
    func testCalculateTimeLeft() {
        let currentTime = Int(Date().timeIntervalSince1970)
        let timeToAdd: Int = 2 * 3_600 + 30 * 60 + 10
        let futureCooltime = currentTime + timeToAdd
        let (hours, minutes, seconds) = Utils.calculateTimeLeft(cooltime: futureCooltime)

        XCTAssertEqual(hours, 2)
        XCTAssertEqual(minutes, 30)
        XCTAssertEqual(seconds, 10)
    }

}
