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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension CompleteRequestViewController: CompleteRequestViewControllerProtocol {
    func goBack() {
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers
        navigationArray.remove(at: navigationArray.count - 2)
        self.navigationController?.viewControllers = navigationArray
    }
}
