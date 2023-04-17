import UIKit


protocol CooltimeDataSourceProtocol {
    func fetch() throws -> TimeInterval
    func remove()
    func set(unixTime: TimeInterval)
}

class CooltimeDataSource: CooltimeDataSourceProtocol {

    static let COOLTIME_KEY = "COOLTIME"
    func fetch() throws -> TimeInterval {
        let cooltime = UserDefaults.standard.value(forKey: Self.COOLTIME_KEY)
        guard let cooltime = cooltime else {
            throw CooltimeDataSourceError.dataNotFound
        }
        guard let cooltime = cooltime as? TimeInterval else {
            throw CooltimeDataSourceError.wrongValueType
        }
        return cooltime
    }

    func remove() {
        UserDefaults.standard.removeObject(forKey: Self.COOLTIME_KEY)
    }

    func set(unixTime: TimeInterval) {
        UserDefaults.standard.set(unixTime, forKey: Self.COOLTIME_KEY)
    }
}
