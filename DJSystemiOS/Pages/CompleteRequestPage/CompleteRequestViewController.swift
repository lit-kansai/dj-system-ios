import SwiftUI
import UIKit

protocol CompleteRequestViewControllerProtocol: AnyObject {
    func goBack()
}

class CompleteRequestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let completeRequestView = CompleteRequestView(controller: self)
        let hostingVC = UIHostingController(rootView: completeRequestView)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
        hostingVC.coverView(parent: view)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

extension CompleteRequestViewController: CompleteRequestViewControllerProtocol {
    func goBack() {
        guard let navigationController = self.navigationController else { return }
        navigationController.popToViewControllerOfType(preserving: SearchRoomViewController.self, animated: true)
    }
}
