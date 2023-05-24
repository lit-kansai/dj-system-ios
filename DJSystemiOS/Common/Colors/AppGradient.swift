import SwiftUI

struct AppGradient {
    let color: Gradient
    init(gradient: Gradient) {
        self.color = gradient
    }
}

extension AppGradient {
    static let orangeToRed: AppGradient = AppGradient(gradient: .orangeToRed)
}

