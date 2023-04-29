import Foundation
import UIKit

protocol APIClientProtocol {
    func get<T: Decodable>(from endpoint: Endpoint, dataType type: T.Type) async -> Result<T, APIClientError>
    func post<T: Decodable>(to endpoint: Endpoint, with data: Encodable, responseDataType type: T.Type) async -> Result<T, APIClientError>
}

struct APIClient {
    private let urlSession: URLSession
    private let baseURL: URL
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    init(
        urlSession: URLSession = .shared,
        baseURL: URL
    ) {
        self.urlSession = urlSession
        self.baseURL = baseURL
    }

}

extension APIClient: APIClientProtocol {

    func get<T: Decodable>(from endpoint: Endpoint, dataType type: T.Type) async -> Result<T, APIClientError> {
        let url = combineURL(baseURL, endpoint)
        let urlRequest = URLRequest(url: url)
        do {
            let (data, urlResponse) = try await urlSession.data(for: urlRequest)
            /*
            Whenever you make HTTP URL load requests, any response objects you get back from the URLSession, NSURLConnection, or NSURLDownload class are instances of the HTTPURLResponse class.
            */
            let apiResponseError = handleAPIResponse(data: data, urlResponse: urlResponse)
            if let apiResponseError { return .failure(apiResponseError) }
            let responseData = try decoder.decode(T.self, from: data)
            return .success(responseData)
        } catch let error as DecodingError {
            return .failure(.internalError(.failedToDecodeData(error: error)))
        } catch let error as NSError {
            return .failure(.networkError(NetworkError(error: error)))
        }
    }

    func post<T: Decodable>(to endpoint: Endpoint, with data: Encodable, responseDataType type: T.Type) async -> Result<T, APIClientError> {
        do {
            let url = combineURL(baseURL, endpoint)
            let body = try encoder.encode(data)
            let urlRequest = URLRequest(url: url, requestBody: body)
            let (data, urlResponse) = try await urlSession.data(for: urlRequest)
            let apiResponseError = handleAPIResponse(data: data, urlResponse: urlResponse)
            if let apiResponseError { return .failure(apiResponseError) }
            let responseData = try decoder.decode(T.self, from: data)
            return .success(responseData)
        } catch let error as EncodingError {
            return .failure(.internalError(.failedToEncodeData(error: error)))
        } catch let error as DecodingError {
            return .failure(.internalError(.failedToDecodeData(error: error)))
        } catch let error as NSError {
            return .failure(.networkError(NetworkError(error: error)))
        }
    }

    private func handleAPIResponse(data: Data, urlResponse: URLResponse) -> APIClientError? {
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            return .unexpectedAPIClientError(.unexpectedUrlResponse(urlResponse: urlResponse))
        }
        if 400..<600 ~= httpResponse.statusCode {
            return .httpError(HTTPError(statusCode: httpResponse.statusCode, data: data))
        }
        return nil
    }
}

