import Foundation

enum StatusCode {
    case ok
    case badRequest
    case unauthorized
    case notFound
    case internalServerError
    case notImplemented
    case badGateway
    case serviceUnavailable

    var value: Int {
        switch self {
        case .ok: return 200
        case .badRequest: return 400
        case .unauthorized: return 401
        case .notFound: return 404
        case .internalServerError: return 500
        case .notImplemented: return 501
        case .badGateway: return 502
        case .serviceUnavailable: return 503
        }
    }
}
