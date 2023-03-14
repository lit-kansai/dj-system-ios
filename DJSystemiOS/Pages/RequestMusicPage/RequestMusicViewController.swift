import SwiftUI
import UIKit

class RequestMusicViewController: UIViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let requestMusicView = RequestMusicView()
        let hostingVC = UIHostingController(rootView: requestMusicView)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
        hostingVC.coverView(parent: view)
    }

}
