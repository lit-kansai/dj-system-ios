import Foundation

extension URL {
    static func extractRoomID(inputURL: String) -> Result<String, InvalidURLError> {
        let result = inputURL.capture(pattern: RegularExpression.roomURL, group: 1)
        guard let result else { return .failure(.invalidFormat) }
        return .success(result)
    }
}

