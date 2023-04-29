import Foundation

extension URLRequest {
    init(url: URL, requestBody: Data) {
        self.init(url: url)
        self.httpMethod = "POST"
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.httpBody = requestBody
    }
}
