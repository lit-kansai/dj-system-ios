import Foundation

extension URLRequest {
    init(url: URL, requestBody: Data) {
        self.init(url: url)
        self.httpMethod = "POST"
        self.httpBody = requestBody
    }
}
