import UIKit

final class AppTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchRoomViewController = UINavigationController(rootViewController: Factory.searchRoomViewController())
        let myPlaylistViewController = UINavigationController(rootViewController: Factory.myPlaylistViewController())
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemOrange
        UITabBar.appearance().backgroundColor = .systemGray6
        tabBar.tintColor = .systemOrange

        viewControllers = [myPlaylistViewController, searchRoomViewController]
        selectedIndex = 0
    }
}

