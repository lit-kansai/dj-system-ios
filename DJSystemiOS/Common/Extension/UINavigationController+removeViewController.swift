import UIKit

extension UINavigationController {
    func removeViewController<T: UIViewController>(preserving: T.Type, animated: Bool) {
        viewControllers.removeAll { $0 is T }
    }
}
