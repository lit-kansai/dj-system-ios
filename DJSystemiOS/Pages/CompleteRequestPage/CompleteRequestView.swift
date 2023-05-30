import SwiftUI

struct CompleteRequestView: View {
    weak var controller: CompleteRequestViewControllerProtocol?
    init(controller: CompleteRequestViewControllerProtocol) {
        self.controller = controller
    }
    var body: some View {
        VStack {
            Text("送信完了")
                .foregroundColor(Color(.label))
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(R.image.requested)
            Text("リクエストしてくれてありがとう!")
                .foregroundColor(Color(.label))
                .font(.headline)
                .bold()
            Button(action: {
                controller?.goBack()
            }, label: {
                Text("戻る")
                    .foregroundColor(Color(.white))
                    .font(.footnote)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            })
            .background(Color.pink)
            .cornerRadius(10)
            Spacer()
        }
        .padding()
    }
}

struct CompleteRequestView_Previews: PreviewProvider {
    static let completeRequestViewController = CompleteRequestViewController()
    static var previews: some View {
        CompleteRequestView(controller: Self.completeRequestViewController)
    }
}
