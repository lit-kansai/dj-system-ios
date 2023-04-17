import UIKit

struct CooltimeService {
    private let cooltimeDataSource: CooltimeDataSourceProtocol

    init(dataSource: CooltimeDataSourceProtocol) {
        self.cooltimeDataSource = dataSource
    }

    func getRemainingCooltime() -> String? {
        if hasExpired { return nil }
        let cooltime = try? cooltimeDataSource.fetch()
        guard let cooltime = cooltime else { return nil }
        let (hours, minutes, seconds) = calculateTimeLeft(cooltime: Int(cooltime))
        let formattedTime = formatTime(
            hours: hours,
            minutes: minutes,
            seconds: seconds
        )
        return formattedTime
    }

    func calculateTimeLeft(cooltime: Int) -> (Int, Int, Int) {
        let currentTime = Int(Date().timeIntervalSince1970)
        let timeDifference = cooltime - currentTime
        let hours = Int(timeDifference) / 3_600
        let minutes = (Int(timeDifference) % 3_600) / 60
        let seconds = Int(timeDifference) % 60
        return (hours, minutes, seconds)
    }

    func formatTime(hours: Int, minutes: Int, seconds: Int) -> String {
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func saveCooltime(unixTime: TimeInterval) {
        cooltimeDataSource.set(unixTime: unixTime)
    }

    func removeExpiredCooltime() {
        cooltimeDataSource.remove()
    }

    var hasExpired: Bool {
        let cooltime = try? cooltimeDataSource.fetch()
        guard let cooltime = cooltime else { return true }
        let currentTime = Date().timeIntervalSince1970
        return cooltime <= currentTime
    }
}
