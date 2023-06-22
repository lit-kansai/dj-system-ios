import Foundation

struct RegularExpression {
    static var roomURL: String {
        switch AppConfig.shared.environment {
        case .debug:
            return "https://stg-dj\\.life-is-tech\\.com/([A-Za-z0-9_-]+)$"
        case .release:
            return "https://dj\\.life-is-tech\\.com/([A-Za-z0-9_-]+)$"
        }
    }
}
