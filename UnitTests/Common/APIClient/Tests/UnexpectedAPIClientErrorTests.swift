import XCTest
import Foundation
@testable import DJSystemiOS

final class UnexpectedAPIClientErrorTests: XCTestCase {
    func testUnexpectedAPIClientError() async {
//        let expectation = XCTestExpectation(description: "unexpectedAPIClientError test")

        let invalidUrlResponse = URLResponse(url: URL(string: "https://example.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let session = createSessionWithUnexpectedUrlResponse(urlResponse: invalidUrlResponse)

        let apiClient = APIClient(urlSession: session, baseURL: URL(string: "https://example.com")!)

        let result: Result<Sample, APIClientError> = await apiClient.get(from: .musicTop(roomId: "hoge"))

        switch result {
        case .success:
            XCTFail("Expected unexpectedAPIClientError, but got success.")
        case .failure(let error):
            guard case .unexpectedAPIClientError(let apiClientError) = error else {
                XCTFail("Expected unexpectedAPIClientError, but got \(error)")
                return
            }
            XCTAssertEqual(
                apiClientError.url,
                UnexpectedAPIClientError.init(urlResponse: invalidUrlResponse).url
            )
//            expectation.fulfill()
        }

//        wait(for: [expectation], timeout: 10)
    }
    private func createSessionWithUnexpectedUrlResponse(urlResponse: URLResponse) -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [UnexpectedUrlResponseHandler.self]
        UnexpectedUrlResponseHandler.urlResponse = urlResponse
        return URLSession(configuration: configuration)
    }
}
