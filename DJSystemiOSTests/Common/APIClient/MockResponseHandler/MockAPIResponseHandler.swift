import Foundation

class MockAPIResponseHandler: URLProtocol {
    private static var mockHTTPURLResponse: HTTPURLResponse?
    private static var mockJsonData: Data?

    private var httpURLResponse: HTTPURLResponse {
        guard let response = MockAPIResponseHandler.mockHTTPURLResponse else {
            fatalError("httpURLResponse is not set")
        }
        return response
    }

    private var responseJsonData: Data {
        guard let jsonData = MockAPIResponseHandler.mockJsonData else {
            fatalError("jsonData is not set")
        }
        return jsonData
    }

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let client = self.client else { fatalError("client is not found ") }
        guard request.url != nil else { fatalError("Invalid request.url") }

        client.urlProtocol(self, didReceive: httpURLResponse, cacheStoragePolicy: .notAllowed)
        client.urlProtocol(self, didLoad: responseJsonData)
        client.urlProtocolDidFinishLoading(self)
    }

    class func registerResponse(httpURLResponse: HTTPURLResponse, jsonData: Data) {
        mockHTTPURLResponse = httpURLResponse
        mockJsonData = jsonData
    }

    override func stopLoading() {
        // Nothing to do here.
    }
}
