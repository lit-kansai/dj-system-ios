import Foundation

enum CooltimeDataSourceError: LocalizedError {
    case wrongValueType
    case dataNotFound

    var errorDescription: String? {
        switch self {
        case .wrongValueType:
            return "wrong type data is stored for this key"
        case .dataNotFound:
            return "data is not found for this key."
        }
    }
}
