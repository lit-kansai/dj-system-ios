import Foundation

enum Factory {
    static func searchMusicViewController(roomId: String) -> SearchMusicViewController {
        let searchMusicViewController = SearchMusicViewController(roomId: roomId, roomAPI: Room.API(), router: SearchMusicRouter())
        return searchMusicViewController
    }

    static var cooltimeService: CooltimeService {
        let cooltimeService = CooltimeService(dataSource: CooltimeDataSource())
        return cooltimeService
    }
}
