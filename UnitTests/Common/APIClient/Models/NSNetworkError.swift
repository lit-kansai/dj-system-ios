import Foundation

class NSNetworkError: NSError {
    init(error: NetworkError) {
        let userInfo: [String: Any] = [
            NSLocalizedDescriptionKey: "Network error: \(error)"
        ]
        super.init(domain: "CustomNetworkErrorDomain", code: error.code, userInfo: userInfo)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
