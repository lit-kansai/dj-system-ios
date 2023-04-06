import UIKit

struct CooltimeService {
    static let COOLTIME_KEY = "COOLTIME"
    func getCooltime() -> String? {
        let cooltime = fetchCooltime()
        guard let cooltime = cooltime else { return nil }
        let currentTime = Date().timeIntervalSince1970
        let timeDifference = cooltime - currentTime
        let hours = Int(timeDifference) / 3_600
        let minutes = (Int(timeDifference) % 3_600) / 60
        let seconds = Int(timeDifference) % 60

        if hours > 0 {
            let formattedTime = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            return formattedTime
        }

        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        return formattedTime
    }

    func saveCooltime(unixTime: TimeInterval) {
        UserDefaults.standard.set(time, forKey: Self.COOLTIME_KEY)
    }

    func removeExpiredCooltime() {
        UserDefaults.standard.removeObject(forKey: Self.COOLTIME_KEY)
    }

    func fetchCooltime() -> TimeInterval? {
        let cooltime = UserDefaults.standard.value(forKey: Self.COOLTIME_KEY)
        guard let cooltime = cooltime else {
            // TODO: print以外の方法探したい
            print("Key is not found")
            return nil
        }
        guard let cooltime = cooltime as? TimeInterval else {
            print("Value is not equivalent to TimeInterval")
            return nil
        }
        return cooltime
    }

    var hasExpired: Bool {
        let cooltime = UserDefaults.standard.value(forKey: Self.COOLTIME_KEY)
        guard let cooltime = cooltime else {
            // TODO: print以外の方法探したい
            print("Key is not found")
            return false
        }
        guard let cooltime = cooltime as? TimeInterval else {
            print("Value is not equivalent to TimeInterval")
            return false
        }
        let currentTime = Date().timeIntervalSince1970
        return cooltime <= currentTime
    }
}
