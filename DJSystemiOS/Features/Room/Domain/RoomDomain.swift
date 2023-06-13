import Foundation
import RealmSwift

struct RoomOverview: Codable {
    let id: String
    let name: String
    let description: String
}

// Realm用にclassで作ってます
final class RoomHistory: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var detail: String
    @Persisted var emojiIcon: String

    init(id: String, name: String, description: String, emojiIcon: String) {
        super.init()
        self.id = id
        self.name = name
        self.detail = description
        self.emojiIcon = emojiIcon
    }

}
