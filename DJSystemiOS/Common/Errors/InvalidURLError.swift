import Foundation

enum InvalidURLError: LocalizedError {
    case invalidFormat

    var errorDescription: String? {
        switch self {
        case .invalidFormat:
            return "URLの形式が無効です"
        }
    }
}
