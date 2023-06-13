import SwiftUI

struct RequestMusicView: View {
    weak var controller: RequestMusicViewControllerProtocol?
    @ObservedObject var dataSource: DataSource
    let music: DataModel.Music

    init(controller: RequestMusicViewControllerProtocol, music: DataModel.Music) {
        self.controller = controller
        self.dataSource = controller.state
        self.music = music
    }

    var body: some View {
        VStack {
            VStack {
                Text("リクエストする楽曲")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    AsyncImage(url: music.thumbnail) { image in
                        image.image?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 57, height: 57)
                    }
                    VStack {
                        Text(music.name)
                            .font(.headline)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(music.artists)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.caption2)
                    }
                }
            }
            Group {
                VStack {
                    Text("お便り")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 1)
                    Text("ニックネーム")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ZStack(alignment: .leading) {
                        if dataSource.radioName.isEmpty {
                            Text("がっしー")
                                .padding(10)
                                .foregroundColor(Color(UIColor.gray))
                        }
                        TextField("", text: $dataSource.radioName)
                            .padding(10)
                            .border(.gray)
                    }
                }
                .padding(.vertical, 10)
                VStack {
                    Text("メッセージ")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            TextView(message: $dataSource.message, placeHolder: "がっしーだよー")
            Spacer()
            Button(action: {
                Task {
                    await controller?.postMusic(radioName: dataSource.radioName, message: dataSource.message)
                }
            }, label: {
                Text("リクエスト送る")
                    .foregroundColor(.white)
                    .font(.footnote)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            })
            .background(Color.pink)
            .cornerRadius(10)
        }
        .padding()
    }
}

extension RequestMusicView {
    class DataSource: ObservableObject {
        @Published var radioName: String = ""
        @Published var message: String = ""
    }
}

struct RequestMusicView_Previews: PreviewProvider {
    static var previews: some View {
        RequestMusicView(controller: RequestMusicViewController(cooltimeService: Factory.cooltimeService, roomId: "sample-gassi", music: .mockData), music: .mockData)
    }
}

struct TextView: UIViewRepresentable {
    @Binding var message: String
    var placeHolder: String

    func makeUIView(context: UIViewRepresentableContext<TextView>) -> PlaceTextView {
        let textView = PlaceTextView()
        textView.placeHolderLabel.textColor = UIColor.gray
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1
        return textView
    }

    func updateUIView(_ uiTextView: PlaceTextView, context: Context) {
        uiTextView.text = message
        uiTextView.placeHolder = placeHolder
        uiTextView.updateView()
    }

    func makeCoordinator() -> TextView.Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        let contentView: TextView

        init(_ contentView: TextView) {
            self.contentView = contentView
        }

        private func textFieldDidEndEditing(_ textView: UITextView) {
            contentView.message = textView.text ?? ""
        }
    }
}

final class PlaceTextView: UITextView {
    var placeHolderLabel: UILabel!
    var placeHolder: String = "" {
        willSet {
            self.placeHolderLabel.text = newValue
            self.placeHolderLabel.sizeToFit()
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        textContainerInset = UIEdgeInsets(top: 10, left: 0, bottom: 8, right: 0)
        textContainer.lineFragmentPadding = 10
        placeHolderLabel = UILabel(frame: CGRect(x: 10, y: 6, width: 0, height: 0))
        addSubview(placeHolderLabel)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textChanged(notification:)),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
    }
    @objc
    private func textChanged(notification: NSNotification) {
        updateView()
    }
    func updateView() {
        self.placeHolderLabel.isHidden = (placeHolder.isEmpty || !text.isEmpty)
    }
}
