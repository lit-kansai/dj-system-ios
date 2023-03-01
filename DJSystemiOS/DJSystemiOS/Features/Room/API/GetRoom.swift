import Foundation
import Moya

protocol RoomAPIProtocol {
    func getRoom(id: String) async throws -> RoomOverview
}

extension Room.API: RoomAPIProtocol {
    func getRoom(id: String) async throws -> RoomOverview {
        return try await withCheckedThrowingContinuation { continuation in
            Room.API.provider.request(.getRoom(id: id)) { result in
                switch result {
                case let .success(response):
                    do {
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        let roomOverview = try filteredResponse.map(RoomOverview.self)
                        continuation.resume(returning: roomOverview)
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


