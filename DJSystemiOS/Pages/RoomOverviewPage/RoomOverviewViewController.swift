import SwiftUI
import UIKit

protocol RoomOverviewControllerProtocol: AnyObject {
    func toSearchMusicPage()
    var state: RoomOverviewPageView.DataSource { get set }
}

class RoomOverviewViewController: UIViewController, RoomOverviewControllerProtocol {
    @ObservedObject var state: RoomOverviewPageView.DataSource = .init()

    /// ルームの概要
    private let roomOverview: RoomOverview

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(roomOverview: RoomOverview) {
        self.roomOverview = roomOverview
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
        print(roomOverviewPageView.$dataSource.$name)
    }

    func toSearchMusicPage() {
        self.navigationController?.pushViewController(SearchMusicViewController(), animated: true)
    }

}
