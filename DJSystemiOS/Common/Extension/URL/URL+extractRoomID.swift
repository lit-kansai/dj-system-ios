import Foundation

// QRから読んだURLからroomIDだけ正規表現で抜き出す
// Result<String, InvalidURLError>型で返ってくるので良い感じに使ってくださいー
// let result = URL.extractRoomID(inputURL: "https://dj-life-is-tech.com/sample-gassi")
// print(result) // .success("sample-gassi")
extension URL {
    static func extractRoomID(inputURL: String) -> Result<String, InvalidURLError> {
        let result = inputURL.capture(pattern: RegularExpression.roomURL, group: 1)
        guard let result else { return .failure(.invalidFormat) }
        return .success(result)
    }
}

