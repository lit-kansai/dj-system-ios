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
    }
}

extension RoomOverviewViewController: RoomOverviewControllerProtocol {
    func toSearchMusicPage() {
        self.navigationController?.pushViewController(SearchMusicViewController(), animated: true)
    }
}
