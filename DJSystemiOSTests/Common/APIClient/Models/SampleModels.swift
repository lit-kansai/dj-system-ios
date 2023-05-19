import Foundation

struct SomeNonEncodableModel: Encodable {
    let value = Date()
    func encode(to encoder: Encoder) throws {
        throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: [], debugDescription: "Cannot encode Date directly"))
    }
}

struct SomeDecodableModel: Codable {
    let id: Int
    let name: String
}
