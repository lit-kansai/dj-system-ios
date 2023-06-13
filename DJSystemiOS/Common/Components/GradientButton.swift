import SwiftUI

struct GradientButton: View {
    let appGradient: AppGradient
    let title: String
    let action: () -> Void
    var body: some View {
        Button(title, action: action)
            .buttonStyle(AppButtonStyle(gradient: appGradient))
    }
}

struct GradientButton_Previews: PreviewProvider {
    static var previews: some View {
        GradientButton(
            appGradient: .orangeToRed,
            title: "曲をリクエストする"
        ) {}
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

