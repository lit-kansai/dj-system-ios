import Foundation
import UIKit

extension UISearchBar {
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return searchTextField
        } else {
            return value(forKey: "_background") as? UITextField
        }
    }
}
