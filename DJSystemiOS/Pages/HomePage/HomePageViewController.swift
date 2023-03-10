import SwiftUI
import UIKit

protocol HomePageControllerProtocol: AnyObject {
    func searchRoom(byId id: String) async
    var state: HomePageView.DataSource { get set }
}

final class HomePageViewController: UIViewController {
    @ObservedObject var state: HomePageView.DataSource = .init()
    // TODO: 後でletに変える
    var roomAPI: GetRoomAPIProtocol = Room.API()

    init(roomAPI: GetRoomAPIProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.roomAPI = roomAPI
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.roomAPI = Room.API()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let homePage = HomePageView(controller: self)
        let hostingVC = UIHostingController(rootView: homePage)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
        hostingVC.coverView(parent: view)
    }

}

extension HomePageViewController: HomePageControllerProtocol {
    func searchRoom(byId id: String) async {
        let roomOverview = try! await roomAPI.getRoom(id: id)
        Task.detached { @MainActor [state] in
            state.currentRoom = roomOverview
        }
    }
}

