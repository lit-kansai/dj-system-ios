import Foundation

extension Room.API {
    struct GetRoomResponse: Codable {
        let id: String
        let name: String
        let description: String
        let roomCooltime: Int
    }
}

protocol GetRoomAPIProtocol {
    func getRoom(id: String) async -> Result<Room.API.GetRoomResponse, APIClientError>
}

extension Room.API: GetRoomAPIProtocol {
    func getRoom(id: String) async -> Result<GetRoomResponse, APIClientError> {
        let client = APIClient(baseURL: AppConfig.BaseAPIURL)
        let result = await client.get(from: .getRoom(roomId: id), dataType: Room.API.GetRoomResponse.self)
        return result
    }
}


