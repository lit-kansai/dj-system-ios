import SwiftUI

struct RoomOverviewPageView: View {

    weak var controller: RoomOverviewControllerProtocol?
    @ObservedObject var dataSource: DataSource

    init(controller: RoomOverviewControllerProtocol) {
        self.controller = controller
        self.dataSource = controller.state
    }

    var body: some View {
        VStack {
            if let description = controller?.state.description {
                Text(description)
                    .foregroundColor(Color(.label))
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 36)
                Text("リクエストされた曲")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 1)
                ScrollView {
                    ForEach(dataSource.musics, id: \.id) { music in
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
                }
                .padding(.bottom, 10)
            }
            Button {
                controller?.toSearchMusicPage()
            } label: {
                // ボタンのタップ領域をここで指定
                Text("曲をリクエストする")
            }
            .buttonStyle(AppButtonStyle(gradient: AppGradient.orangeToRed))
        }
        .padding(16)

        Spacer()
    }
}

extension RoomOverviewPageView {
    class DataSource: ObservableObject {
        @Published var name: String = ""
        @Published var description: String = ""
        @Published var musics: [DataModel.Music] = []
        init(name: String, description: String) {
            self.name = name
            self.description = description
        }
    }
}

struct RoomOverviewPageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RoomOverviewPageView(controller: RoomOverviewViewController(roomAPI: Room.API(), roomOverview: RoomOverview(id: "sample-gassi", name: "sample-gassi", description: "サンプルの部屋")))
        }
    }
}
