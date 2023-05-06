import Foundation

enum UnexpectedAPIClientError: LocalizedError {
    case unexpectedUrlResponse(urlResponse: URLResponse)
    var errorDescription: String? {
        switch self {
        case .unexpectedUrlResponse(let urlResponse):
            return "Unexpected URL Response \(urlResponse.description)"
        }
    }

    var url: URL? {
        switch self {
        case .unexpectedUrlResponse(let urlResponse):
            return urlResponse.url
        }
    }

    init(urlResponse: URLResponse) {
        self = .unexpectedUrlResponse(urlResponse: urlResponse)
    }
}

