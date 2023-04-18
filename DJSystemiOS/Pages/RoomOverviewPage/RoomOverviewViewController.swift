import SwiftUI
import UIKit

class RoomOverviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let roomOverviewPageView = RoomOverviewPageView()
        let hostingVC = UIHostingController(rootView: roomOverviewPageView)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
        hostingVC.coverView(parent: view)
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }

}
