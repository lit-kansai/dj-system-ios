import Foundation

extension Room.API {
    struct RequestMusicInput {
        let musics: [String]
        let radioName: String
        let message: String
    }
    struct RequestMusicResponse: Codable {
        let ok: Bool
    }
}

protocol RequestMusicProtocol {
    func requestMusic(input: Room.API.RequestMusicResponse) async throws -> Room.API.RequestMusicResponse
}

extension Room.API: RequestMusicProtocol {
    func requestMusic(input: Room.API.RequestMusicResponse) async throws -> Room.API.RequestMusicResponse {
        return Room.API.RequestMusicResponse(ok: false)
    }

}
