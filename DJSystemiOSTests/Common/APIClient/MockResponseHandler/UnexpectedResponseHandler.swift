import Foundation

class UnexpectedUrlResponseHandler: URLProtocol {
    static var urlResponse: URLResponse?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let urlResponse = Self.urlResponse else {
            fatalError("urlResponse is not set.")
        }
        client?.urlProtocol(self, didReceive: urlResponse, cacheStoragePolicy: .notAllowed)
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
