import Foundation

protocol AppConfigProtocol {
    var environment: Environment { get }
    var BaseAPIURL: URL { get }
}

enum Environment: String {
    case debug = "DEBUG"
    case release = "RELEASE"
}

struct AppConfig: AppConfigProtocol {
    var environment: Environment {
        guard let environmentString = Bundle.main.object(forInfoDictionaryKey: "Environment") as? String,
              let environment = Environment(rawValue: environmentString)
        else {
            fatalError("Fail to load `Environment` from `Info.plist`.")
        }
        return environment
    }

    var BaseAPIURL: URL {
        switch environment {
        case .debug:
            return URL(string: "https://stg-dj-api.life-is-tech.com")!
        case .release:
            return URL(string: "https://dj-api.life-is-tech.com")!
        }
    }
}
