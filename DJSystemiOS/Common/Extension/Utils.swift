import Foundation

enum Utils {}

extension Utils {
    static func formatTime(hours: Int, minutes: Int, seconds: Int) -> String {
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        return String(format: "%02d:%02d", minutes, seconds)
    }

    static func calculateTimeLeft(cooltime: Int) -> (Int, Int, Int) {
        let currentTime = Int(Date().timeIntervalSince1970)
        let timeDifference = cooltime - currentTime
        let hours = Int(timeDifference) / 3_600
        let minutes = (Int(timeDifference) % 3_600) / 60
        let seconds = Int(timeDifference) % 60
        return (hours, minutes, seconds)
    }
}


