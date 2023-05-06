import Foundation

enum APIClientError: LocalizedError {
    case httpError(HTTPError)
    case unexpectedAPIClientError(UnexpectedAPIClientError)
    case internalError(InternalError)
    case networkError(NetworkError)

    var errorDescription: String? {
        switch self {
        case .httpError(let error):
            return error.errorDescription
        case .unexpectedAPIClientError(let error):
            return error.errorDescription
        case .internalError(let error):
            return error.errorDescription
        case .networkError(let error):
            return error.errorDescription
        }
    }
}

