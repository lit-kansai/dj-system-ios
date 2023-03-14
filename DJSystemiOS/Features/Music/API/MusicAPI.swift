import Foundation
import Moya

extension API {
    enum Music {
        case searchMusics(id: String, query: String)
    }
}
extension API.Music: TargetType {

    var baseURL: URL { URL(string: "https://stg-dj-api.life-is-tech.com")! }
    var path: String {
        switch self {
        case .searchMusics(let id, _):
            return "/room/\(id)/music/search"
        }
    }

    var method: Moya.Method {
        switch self {
        case .searchMusics:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .searchMusics(_, let query):
            return .requestParameters(parameters: ["query": query], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
