import Foundation

extension Room.API {
    typealias GetRequestedMusicsResponse = [DataModel.Music]
}

protocol GetRequestMusicsProtocol {
    func getRequestMusics(of id: String) async -> Result<Room.API.GetRequestedMusicsResponse, APIClientError>
}

extension Room.API: GetRequestMusicsProtocol {
    func getRequestMusics(of id: String) async -> Result<GetRequestedMusicsResponse, APIClientError> {
        return .success(DataModel.Music.Mock.musics)
    }
}
