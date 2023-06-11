@testable import DJSystemiOS
import XCTest

final class SuccessfulCooltimeDataSource: CooltimeDataSourceProtocol {
    func fetch() throws -> TimeInterval {
        return Date().timeIntervalSince1970 + 1000
    }
    func remove() {}
    func set(unixTime: TimeInterval) {}
}

final class FailableCooltimeDataSource: CooltimeDataSourceProtocol {
    func fetch() throws -> TimeInterval {
        return Date().timeIntervalSince1970 - 1000
    }
    func remove() {}
    func set(unixTime: TimeInterval) {}
}

final class CooltimeSeriviceTests: XCTestCase {
    func testHasExpired() {
        let successfullCooltimeService = CooltimeService(dataSource: SuccessfulCooltimeDataSource())
        let failableCooltimeService = CooltimeService(dataSource: FailableCooltimeDataSource())
        XCTAssertFalse(successfullCooltimeService.hasExpired)
        XCTAssertTrue(failableCooltimeService.hasExpired)
    }
}
