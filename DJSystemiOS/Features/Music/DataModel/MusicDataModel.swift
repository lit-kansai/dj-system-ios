import Foundation

extension DataModel {
    struct Music: Codable {}
}

struct Music: Codable {
    let id: String
    let name: String
    let artists:String
    let thumbnail: URL
}

extension Music {
    static let mockData: Music = .init(id: "spotify:track:67T4aWFCAbMNWKamvI3piH", name: "ray", artists: "BUMP OF CHICKEN, 初音ミク", thumbnail: URL(string: "https://i.scdn.co/image/ab67616d0000b2731bc3a96706495fb0a1dbdffd")!)
}
