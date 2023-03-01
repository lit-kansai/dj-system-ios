import UIKit
import SwiftUI

protocol HomePageControllerProtocol: AnyObject {
    func searchRoom(byId id: String) async
    var state: HomePageView.DataSource { get set }
}

final class HomePageController: UIViewController {
    @ObservedObject var state: HomePageView.DataSource = .init()
    // TODO: 後でletに変える
    var roomAPI: RoomAPIProtocol = Room.API()
    
    init(roomAPI: RoomAPIProtocol) {
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

extension HomePageController: HomePageControllerProtocol {
    func searchRoom(byId id: String) async {
        let roomOverview = try! await roomAPI.getRoom(id: id)
        Task.detached { @MainActor [state] in
            state.currentRoom = roomOverview
        }
    }
}

extension UIHostingController {
    func coverView(parent: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: parent.topAnchor),
            view.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            view.leadingAnchor.constraint(equalTo: parent.leadingAnchor)
        ])
    }
}
