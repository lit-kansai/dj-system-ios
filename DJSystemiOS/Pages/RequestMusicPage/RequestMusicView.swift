import SwiftUI

struct RequestMusicView: View {
    weak var controller: RequestMusicViewControllerProtocol?
    @ObservedObject var dataSource: DataSource
    let music: Music
    let roomId: String

    init(controller: RequestMusicViewControllerProtocol, music: Music, roomId: String) {
        self.controller = controller
        self.dataSource = controller.state
        self.music = music
        self.roomId = roomId
    }

    var body: some View {
        VStack {
            VStack {
                VStack {
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
        }
        .background(Color(red: 30 / 256, green: 30 / 256, blue: 30 / 256))
    }
}

extension RequestMusicView {
    class DataSource: ObservableObject {
        @Published var radioName: String = ""
        @Published var message: String = ""
    }
}

//struct RequestMusicView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            RequestMusicView()
//                .navigationTitle("曲をリクエストする")
//        }
//
//    }
//}
