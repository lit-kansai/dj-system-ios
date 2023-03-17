import Foundation

extension DataModel {
    struct Music: Codable {}
}
struct Music: Codable {
    let name: String
    let artists:String
    let thumbnail: URL
}

