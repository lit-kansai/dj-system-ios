import Foundation

enum Endpoint {
    case roomOverview(roomId: String)
    case musicTop(roomId: String)
    case musicSearch(roomId: String, query: String)
    case requestMusic(roomId: String)
    case getRoom(roomId: String)

    var path: String {
        switch self {
        case .roomOverview(let roomId):
            return "/room/\(roomId)"
        case .musicTop(let roomId):
            return "/room/\(roomId)/music/top"
        case .musicSearch(let roomId, let query):
            let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            return "/room/\(roomId)/music/search?q=\(encodedQuery ?? "")"
        case .requestMusic(let roomId):
            return "/room/\(roomId)/request"
        case .getRoom(let roomId):
            return "/room/\(roomId)"
        }
    }
}

