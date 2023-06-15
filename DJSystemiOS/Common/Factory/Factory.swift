import Foundation
import UIKit

enum Factory {

    static func myPlaylistViewController() -> UIViewController {
        let myPlaylistViewController = UIViewController()
        myPlaylistViewController.view.backgroundColor = .white
        myPlaylistViewController.tabBarItem = UITabBarItem(title: "プレイリスト", image: UIImage(systemName: "headphones"), tag: 0)
        myPlaylistViewController.tabBarItem.badgeColor = .systemOrange
        return myPlaylistViewController
    }

    static func searchMusicViewController(roomId: String) -> SearchMusicViewController {
        let searchMusicViewController = SearchMusicViewController(roomId: roomId, roomAPI: Room.API(), router: SearchMusicRouter())
        return searchMusicViewController
    }

    static func searchRoomViewController() -> SearchRoomViewController {
        let searchRoomViewController = SearchRoomViewController(roomAPI: Room.API(), router: SearchRoomRouter())
        searchRoomViewController.tabBarItem = UITabBarItem(title: "共有", image: UIImage(systemName: "globe.asia.australia.fill"), tag: 1)
        searchRoomViewController.tabBarItem.badgeColor = .systemOrange
        return searchRoomViewController
    }

    static var cooltimeService: CooltimeService {
        let cooltimeService = CooltimeService(dataSource: CooltimeDataSource())
        return cooltimeService
    }

    static func appTabBarController() -> UITabBarController {
        return AppTabBarController()
    }
}
