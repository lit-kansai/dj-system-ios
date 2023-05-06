import SwiftUI

struct RequestMusicView: View {
    weak var controller: RequestMusicViewControllerProtocol?
    @ObservedObject var dataSource: DataSource
    let music: Music

    init(controller: RequestMusicViewControllerProtocol, music: Music) {
        self.controller = controller
        self.dataSource = controller.state
        self.music = music
    }

    var body: some View {
        VStack {
            VStack {
                Text("曲をリクエストする")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("リクエストするルーム")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 1)
                Text("ディジェクマクン")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical)
            VStack {
                Text("リクエストする楽曲")
                    .font(.title)
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
                            .font(.title)
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
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 1)
                    Text("ニックネーム")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ZStack(alignment: .leading) {
                        if dataSource.radioName.isEmpty {
                            Text("がっしー")
                                .padding(10)
                                .foregroundColor(Color(white: 0.5))
                        }
                        TextField("", text: $dataSource.radioName)
                            .padding(10)
                            .border(.gray)
                    }
                }
                .padding(.vertical, 10)
                VStack {
                    Text("メッセージ")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ZStack(alignment: .leading) {
                        if dataSource.message.isEmpty {
                            Text("がっしーだよー")
                                .padding(10)
                                .foregroundColor(Color(white: 0.5))
                        }
                        TextField("", text: $dataSource.message)
                            .padding(10)
                            .border(.gray)
                    }
                }
            }
            Spacer()
            Button(action: {
                Task {
                    await controller?.postMusic(radioName: dataSource.radioName, message: dataSource.message)
                }
            }, label: {
                Text("リクエスト送る")
                    .font(.footnote)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            })
            .background(Color.pink)
            .cornerRadius(10)
        }
        .foregroundColor(.white)
        .padding()
        .background(Color(red: 30 / 256, green: 30 / 256, blue: 30 / 256))
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
            RequestMusicView(controller: RequestMusicViewController(roomId: "sample-gassi", music: Music(id: "spotify:track:67T4aWFCAbMNWKamvI3piH", name: "ray", artists: "BUMP OF CHICKEN, 初音ミク", thumbnail: URL(string: "https://i.scdn.co/image/ab67616d0000b2731bc3a96706495fb0a1dbdffd")!)), music: Music(id: "spotify:track:67T4aWFCAbMNWKamvI3piH", name: "ray", artists: "BUMP OF CHICKEN, 初音ミク", thumbnail: URL(string: "https://i.scdn.co/image/ab67616d0000b2731bc3a96706495fb0a1dbdffd")!))
    }
}
