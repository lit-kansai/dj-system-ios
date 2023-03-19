import Foundation
import Moya

protocol GetRoomAPIProtocol {
    func getRoom(id: String) async throws -> RoomOverview
}

extension Room.API: GetRoomAPIProtocol {
    func getRoom(id: String) async throws -> RoomOverview {
        return try await withCheckedThrowingContinuation { continuation in
            Room.API.provider.request(.getRoom(id: id)) { result in
                switch result {
                case let .success(response):
                    do {
                        // Status Code 200...299 の判定
                        if( response.statusCode < 200 || response.statusCode >= 300){
                            continuation.resume(returning: RoomOverview(id: "", name: "", description: ""))
                        } else {
                            print(response.statusCode)
                            let filteredResponse = try response.filterSuccessfulStatusCodes()
                            let roomOverview = try filteredResponse.map(RoomOverview.self)
                            continuation.resume(returning: roomOverview)
                        }
                    } catch let error {
                        print(error.localizedDescription)
                        continuation.resume(throwing: error)
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}


