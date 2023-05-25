import SwiftUI

extension Color {
    struct Light {
        static let orange = Color(uiColor: UIColor(hex: "FFB848"))
        static let red = Color(uiColor: UIColor(hex: "FF6767"))
    }

    struct Dark {
        static let orange = Color(uiColor: UIColor(hex: "CC943A"))
        static let red = Color(uiColor: UIColor(hex: "CC5353"))
    }

    static let appOrange = Color(light: .Light.orange, dark: .Dark.orange)
    static let appRed = Color(light: .Light.red, dark: .Dark.red)
}


