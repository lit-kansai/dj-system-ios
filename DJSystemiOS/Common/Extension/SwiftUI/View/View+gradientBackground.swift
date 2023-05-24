import SwiftUI

extension View {
    func gradientBackground(gradient: Gradient) -> some View {
        return background(LinearGradient(gradient: gradient))
    }
}

