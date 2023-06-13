import Foundation

struct RoomOverview: Codable {
    let id: String
    let name: String
    let description: String
}

// Realm用にclassで作ってます
final class RoomHistory {

    let id: String
    let name: String
    let description: String
    let emojiIcon: Character

    init(id: String, name: String, description: String, emojiIcon: Character) {
        self.id = id
        self.name = name
        self.description = description
        self.emojiIcon = emojiIcon
    }

}
