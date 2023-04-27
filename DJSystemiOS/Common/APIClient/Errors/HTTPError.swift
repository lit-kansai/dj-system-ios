import Foundation

enum HTTPError: LocalizedError {
    case badRequest(data: Data)
    case unauthorized(data: Data)
    case notFound(data: Data)
    case internalServerError(data: Data)
    case notImplemented(data: Data)
    case badGateway(data: Data)
    case serviceUnavailable(data: Data)
    case unknown(statusCode: Int, data: Data)

    var statusCode: Int {
        switch self {
        case .badRequest:
            return 400
        case .unauthorized:
            return 401
        case .notFound:
            return 404
        case .internalServerError:
            return 500
        case .notImplemented:
            return 501
        case .badGateway:
            return 502
        case .serviceUnavailable:
            return 503
        case .unknown(let statusCode, _):
            return statusCode
        }
    }

    var data: Data {
        switch self {
        case .badRequest(let data):
            return data
        case .unauthorized(let data):
            return data
        case .notFound(let data):
            return data
        case .internalServerError(let data):
            return data
        case .notImplemented(let data):
            return data
        case .badGateway(let data):
            return data
        case .serviceUnavailable(let data):
            return data
        case .unknown(_, let data):
            return data
        }
    }

    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "ステータスコード \(statusCode): 不正なリクエストです"
        case .unauthorized:
            return "ステータスコード \(statusCode): 認証に失敗しました"
        case .notFound:
            return "ステータスコード \(statusCode): 該当するページが見つかりませんでした"
        case .internalServerError:
            return "ステータスコード \(statusCode): サーバーエラーが発生しました"
        case .notImplemented:
            return "ステータスコード \(statusCode): 未実装のリクエストです"
        case .badGateway:
            return "ステータスコード \(statusCode): 不正なゲートウェイです"
        case .serviceUnavailable:
            return "ステータスコード \(statusCode): サービスが利用できません"
        case .unknown(let statusCode, _):
            return "不明なHTTPステータスコード: \(statusCode)"
        }
    }


    init(statusCode: Int, data: Data) {
        switch statusCode {
        case 400:
            self = .badRequest(data: data)
        case 401:
            self = .unauthorized(data: data)
        case 404:
            self = .notFound(data: data)
        case 500:
            self = .internalServerError(data: data)
        case 501:
            self = .notImplemented(data: data)
        case 502:
            self = .badGateway(data: data)
        case 503:
            self = .serviceUnavailable(data: data)
        default:
            self = .unknown(statusCode: statusCode, data: data)
        }
    }
}

