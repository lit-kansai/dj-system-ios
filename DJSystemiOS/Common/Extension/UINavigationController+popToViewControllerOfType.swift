import UIKit
extension UINavigationController {
    func popToViewControllerOfType<T: UIViewController>(preserving: T.Type, animated: Bool) {
        // Get all view controllers on navigation stack
        var newStack = [UIViewController]()

        // Iterate over all view controllers
        for viewController in viewControllers {
            // If this is the view controller we want to keep, add to the new stack
            if viewController is T {
                newStack.append(viewController)
            }
        }

        // If new stack contains any view controller
        if !newStack.isEmpty {
            // Update navigation stack
            setViewControllers(newStack, animated: animated)
        }
    }
}
