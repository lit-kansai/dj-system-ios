import Foundation
import Moya

extension Room {
    struct API {
        static let provider = MoyaProvider<Room.API.TargetType>()
    }
}

