import Foundation

extension Room.API {
    struct RequestMusicInput {
        let musics: [String]
        let radioName: String
        let message: String
        let roomId: String
    }

    struct NewRequestMusicInput: Encodable {
        let musics: [String]
        let radioName: String
        let message: String
    }
    struct RequestMusicResponse: Codable {
        let ok: Bool
    }
}

protocol RequestMusicProtocol {
    func requestMusic(input: Room.API.RequestMusicInput) async throws -> Room.API.RequestMusicResponse
}

// TODO: こいつを実装する
protocol NewRequestMusicProtocol {
    func requestMusic(to id: String, inputs: Room.API.NewRequestMusicInput) async -> Result<Room.API.RequestMusicResponse, APIClientError>
}

extension Room.API: RequestMusicProtocol {
    func requestMusic(input: Room.API.RequestMusicInput) async throws -> Room.API.RequestMusicResponse {
        let url = URL(string: "https://stg-dj-api.life-is-tech.com/room/\(input.roomId)/request")!
        var request = URLRequest(url: url)
        let requestData: [String: Any] = ["musics": input.musics, "radio_name": input.radioName, "message": input.message]
        let bodyData = try? JSONSerialization.data(withJSONObject: requestData, options: [])
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyData
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let decodeData = try? JSONDecoder().decode(RequestMusicResponse.self, from: data) else {
            return RequestMusicResponse(ok: false)
        }
        print(decodeData)
        return decodeData
    }

}
