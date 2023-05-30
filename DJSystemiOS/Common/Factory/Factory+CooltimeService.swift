import Foundation

extension Factory {
    static var cooltimeService: CooltimeService {
        let cooltimeService = CooltimeService(dataSource: CooltimeDataSource())
        return cooltimeService
    }
}
