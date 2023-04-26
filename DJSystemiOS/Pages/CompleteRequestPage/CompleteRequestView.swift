import SwiftUI

struct CompleteRequestView: View {
    weak var controller: CompleteRequestViewControllerProtocol?
    init(controller: CompleteRequestViewControllerProtocol) {
        self.controller = controller
    }
    var body: some View {
        VStack {
            Text("送信完了")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(R.image.requested)
            Text("リクエストしてくれてありがとう!")
                .font(.headline)
                .bold()
            Button(action: {
                controller?.goBack()
            }, label: {
                Text("戻る")
                    .font(.footnote)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            })
            .background(Color.pink)
            .cornerRadius(10)
            Spacer()
        }
        .foregroundColor(.white)
        .padding()
        .background(Color(red: 30 / 256, green: 30 / 256, blue: 30 / 256))
    }
}

struct CompleteRequestView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteRequestView(controller: CompleteRequestViewController())
    }
}
