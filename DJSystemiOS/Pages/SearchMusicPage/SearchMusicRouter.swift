import UIKit

protocol SearchMusicRouterProtocol: AnyObject {
    func transitionToRequestMusicPage(_ navigationController: UINavigationController, roomId: String, music: Music)
}

final class SearchMusicRouter: SearchMusicRouterProtocol {
    func transitionToRequestMusicPage(_ navigationController: UINavigationController, roomId: String, music: Music) {
        // 遷移先のRoomOverViewController
        let requestMusicViewController = RequestMusicViewController(roomId: roomId, music: music)
        // 画面遷移
        navigationController.pushViewController(requestMusicViewController, animated: true)
    }
}
