import Foundation

enum CombineError {
    case invalidURL
}

extension CombineError: LocalizedError {
    var errorDescription: String? {
        return "Invalid URL"
    }
}

func combineURL(_ baseURL: URL, _ endpoint: Endpoint) -> URL {
    var url = baseURL.absoluteString
    if url.hasSuffix("/") { url.removeLast() }

    var path = endpoint.path
    if path.hasPrefix("/") { path.removeFirst()}

    let combinedURLString = url + "/" + path
    guard let combinedURL = URL(string: combinedURLString) else {
        fatalError("Invalid URL")
    }
    return combinedURL
}
