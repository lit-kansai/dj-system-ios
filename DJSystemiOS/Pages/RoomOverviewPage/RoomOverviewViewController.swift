import SwiftUI
import UIKit

protocol RoomOverviewControllerProtocol: AnyObject {
    func toSearchMusicPage()
    var state: RoomOverviewPageView.DataSource { get set }
}

class RoomOverviewViewController: UIViewController {
    @ObservedObject var state: RoomOverviewPageView.DataSource

    /// ルームの概要
    private let roomOverview: RoomOverview

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(roomOverview: RoomOverview) {
        self.roomOverview = roomOverview
        self.state = .init(name: roomOverview.name, description: roomOverview.description)
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let roomOverviewPageView = RoomOverviewPageView(controller: self)
        let hostingVC = UIHostingController(rootView: roomOverviewPageView)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
        hostingVC.coverView(parent: view)

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = state.name
    }
}

extension RoomOverviewViewController: RoomOverviewControllerProtocol {
    func toSearchMusicPage() {
        let cooltimeService = Factory.cooltimeService
        guard cooltimeService.hasExpired else {
            let cooltimeViewController = R.storyboard.main.cooltimeViewController { coder in
                CooltimeViewController(coder: coder, cooltimeService: Factory.cooltimeService, roomId: self.roomOverview.id)
            }
            guard let cooltimeViewController else { fatalError("Failed to create cooltimeViewController") }
            navigationController?.pushViewController(cooltimeViewController, animated: true)
            return
        }

        let searchMusicViewController = Factory.searchMusicViewController(roomId: roomOverview.id)
        navigationController?.pushViewController(searchMusicViewController, animated: true)
    }
}
