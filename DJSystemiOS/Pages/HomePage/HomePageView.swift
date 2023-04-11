import SwiftUI

struct HomePageView: View {
    weak var controller: HomePageControllerProtocol?
    @ObservedObject var dataSource: DataSource

    init(controller: HomePageControllerProtocol) {
        self.controller = controller
        self.dataSource = controller.state
    }

    var body: some View {
        VStack {

            Text("ルームを探す")
                .tint(.black)
                .font(.system(size: 34, weight: .bold, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)

            Text("IDから探す")
                .tint(.black)
                .font(.system(size: 24, weight: .bold, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)

            Text("IDを入力してルームを検索します")
                .tint(.black)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("部屋を検索しよう！", text: $dataSource.searchQuery)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, minHeight: 42)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(.bottom)

            Button("検索する") {
                Task {
                    dataSource.showingAlert = ((try! await controller?.searchRoom(byId: dataSource.searchQuery)) != nil)
                }
            }
            .alert("ルームが見つかりませんでした", isPresented: $dataSource.showingAlert) {
                Button("OK") {
                    // 了解ボタンが押された時の処理
                }
            } message: {
                Text("IDが間違っていないか確認してください")
            }
            .frame(maxWidth: .infinity, minHeight: 42)
            .background(Color.pink)
            .tint(.white)
            .font(.system(size: 12, weight: .bold, design: .default))
            .cornerRadius(10)

            if let currentRoom = dataSource.currentRoom {
                Text("id: \(currentRoom.id)")
                Text("name: \(currentRoom.name)")
                Text("description: \(currentRoom.description)")
            }
        }
        .padding(16)

        Spacer()
    }
}


extension HomePageView {
    class DataSource: ObservableObject {
        @Published var searchQuery = "sample-gassi"
        @Published var currentRoom: RoomOverview?
        @Published var showingAlert = false
    }
}
