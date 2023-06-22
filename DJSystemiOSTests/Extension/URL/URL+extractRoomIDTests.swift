import XCTest
@testable import DJSystemiOS

class RegularExpressionTests: XCTestCase {
    func testExtractRoomID_validRoomID() {
        let testURL = "https://stg-dj.life-is-tech.com/roomID"
        let expectedRoomID = "roomID"
        switch URL.extractRoomID(inputURL: testURL) {
        case .success(let roomID):
            XCTAssertEqual(roomID, expectedRoomID, "Extracted room ID should match the expected format")
        case .failure(let error):
            XCTFail("Test failed with error: \(error)")
        }
    }

    func testExtractRoomID_invalidRoomID_noRoomID() {
        let testURL = "https://stg-dj.life-is-tech.com/"
        switch URL.extractRoomID(inputURL: testURL) {
        case .success(_):
            XCTFail("Test should have failed for invalid room ID")
        case .failure(let error):
            XCTAssertEqual(error, InvalidURLError.invalidFormat, "Error should be invalidFormat for invalid format")
        }
    }

    func testExtractRoomID_invalidRoomID_wrongURL() {
        let testURL = "https://example.com"
        switch URL.extractRoomID(inputURL: testURL) {
        case .success(_):
            XCTFail("Test should have failed for invalid room ID")
        case .failure(let error):
            XCTAssertEqual(error, InvalidURLError.invalidFormat, "Error should be invalidFormat for invalid format")
        }
    }
}

