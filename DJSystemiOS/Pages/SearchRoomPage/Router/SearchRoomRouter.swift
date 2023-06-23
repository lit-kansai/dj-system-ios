import UIKit

protocol SearchRoomRouterProtocol: AnyObject {
    func transitionToRoomOverviewPage(_ navigationController: UINavigationController, roomOverview: RoomOverview)
}

final class SearchRoomRouter: SearchRoomRouterProtocol {
    func transitionToRoomOverviewPage(_ navigationController: UINavigationController, roomOverview: RoomOverview) {
        // 遷移先のRoomOverViewController
        let roomOverviewController = RoomOverviewViewController(roomAPI: Room.API(), roomOverview: roomOverview)
        // 画面遷移
        navigationController.pushViewController(roomOverviewController, animated: true)
    }
}
