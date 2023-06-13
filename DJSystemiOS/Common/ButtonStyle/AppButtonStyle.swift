import SwiftUI

struct AppButtonStyle: ButtonStyle {
    let gradient: AppGradient
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .font(.body.bold())
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(
                LinearGradient(appGradient: gradient)
            )
            .cornerRadius(12)
    }
}
