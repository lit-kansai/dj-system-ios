import Foundation

extension URL {
    static func validateURL(inputURL: String, urlPattern: String) -> Result<URL, InvalidURLError> {
        let trimmedInputURL = inputURL.hasSuffix("/") ? String(inputURL.dropLast()) : inputURL
        guard let url = URL(string: trimmedInputURL) else {
            return .failure(InvalidURLError.invalidFormat)
        }

        if url.absoluteString.contain(of: urlPattern) {
            return .failure(InvalidURLError.invalidFormat)
        }

        return .success(url)
    }

}
