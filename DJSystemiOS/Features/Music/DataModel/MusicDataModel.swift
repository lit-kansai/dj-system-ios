import Foundation
import RealmSwift

extension DataModel {
    struct Music: Codable {
        let id: String
        let name: String
        let artists: String
        let thumbnail: URL
    }
}

extension RealmObject {
    final class Music: Object {
        @Persisted(primaryKey: true)
        var id: String

        @Persisted var name: String
        @Persisted var artists: String
        @Persisted var thumbnail: String
    }
}
