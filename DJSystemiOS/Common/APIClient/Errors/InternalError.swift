import Foundation

enum InternalError: LocalizedError {
    case failedToDecodeData(error: DecodingError)
    case failedToEncodeData(error: EncodingError)

    var errorDescription: String? {
        switch self {
        case .failedToDecodeData(let error):
            return "Failed to decode data: \(error.localizedDescription)"
        case .failedToEncodeData(let error):
            return "Failed to encode data: \(error.localizedDescription)"
        }
    }
}
