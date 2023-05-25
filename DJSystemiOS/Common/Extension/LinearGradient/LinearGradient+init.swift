import SwiftUI

extension LinearGradient {
    init(gradient: Gradient) {
        self.init(
            gradient: gradient,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    init(appGradient: AppGradient) {
        self.init(gradient: appGradient.color)
    }
}

