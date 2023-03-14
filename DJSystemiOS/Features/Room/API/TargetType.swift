import Foundation
import Moya

extension Room.API {
    enum TargetType {
        case getRoom(id: String)
    }
}

extension Room.API.TargetType: TargetType {
    var baseURL: URL { URL(string: "https://stg-dj-api.life-is-tech.com")! }
    var path: String {
        switch self {
        case .getRoom(let id):
            return "/room/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getRoom:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getRoom:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
