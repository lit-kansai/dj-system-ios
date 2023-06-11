import UIKit

protocol CooltimeServiceProtocol: CooltimeWritable, CooltimeReadable {}

protocol CooltimeWritable {
    func saveCooltime(unixTime: TimeInterval)
    func removeExpiredCooltime()
}

protocol CooltimeReadable {
    func getRemainingCooltime() -> String?
    var hasExpired: Bool { get }
}

struct CooltimeService: CooltimeServiceProtocol {
    private let cooltimeDataSource: CooltimeDataSourceProtocol

    init(dataSource: CooltimeDataSourceProtocol) {
        self.cooltimeDataSource = dataSource
    }
}
extension CooltimeService: CooltimeWritable {

    func saveCooltime(unixTime: TimeInterval) {
        cooltimeDataSource.set(unixTime: unixTime)
    }

    func removeExpiredCooltime() {
        cooltimeDataSource.remove()
    }
}

extension CooltimeService: CooltimeReadable {
    var hasExpired: Bool {
        let cooltime = try? cooltimeDataSource.fetch()
        guard let cooltime = cooltime else { return true }
        let currentTime = Date().timeIntervalSince1970
        return cooltime <= currentTime
    }

    func getRemainingCooltime() -> String? {
        if hasExpired { return nil }
        let cooltime = try? cooltimeDataSource.fetch()
        guard let cooltime = cooltime else { return nil }
        let (hours, minutes, seconds) = Utils.calculateTimeLeft(cooltime: Int(cooltime))
        let formattedTime = Utils.formatTime(
            hours: hours,
            minutes: minutes,
            seconds: seconds
        )
        return formattedTime
    }



}

