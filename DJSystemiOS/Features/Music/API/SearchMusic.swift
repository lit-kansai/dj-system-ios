import Foundation

extension Room.API {
    struct SearchMusicInputs: Encodable {
        let roomId: String
        let query: String
    }
    typealias SearchMusicResponse = [DataModel.Music]
}

protocol SearchMusicProtocol {
    func searchMusic(inputs: Room.API.SearchMusicInputs) async -> Result<Room.API.SearchMusicResponse, APIClientError>
}

extension Room.API: SearchMusicProtocol {
    func searchMusic(inputs: SearchMusicInputs) async -> Result<SearchMusicResponse, APIClientError> {
        let client = APIClient(baseURL: AppConfig().BaseAPIURL)
        let requestMusic = await client.get(from: .musicSearch(roomId: inputs.roomId, query: inputs.query), dataType: Room.API.SearchMusicResponse.self)
        return requestMusic
    }
}
