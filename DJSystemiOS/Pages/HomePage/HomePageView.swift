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
                .foregroundColor(Color(.label))
                .font(.system(size: 34, weight: .bold, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)

            Text("IDから探す")
                .foregroundColor(Color(.label))
                .font(.system(size: 24, weight: .bold, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)

            Text("IDを入力してルームを検索します")
                .foregroundColor(Color(.label))
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("部屋を検索しよう！", text: $dataSource.searchQuery)
                .foregroundColor(Color(.label))
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, minHeight: 42)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(.bottom)

            Button("検索する") {
                Task {
                    do {
                        dataSource.showingAlert = await (try controller?.searchRoom(byId: dataSource.searchQuery))!
                        if dataSource.showingAlert {
                            dataSource.currentRoom = RoomOverview(id: "", name: "", description: "")
                            dataSource.resultState = false
                        } else {
                            dataSource.resultState = true
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
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
            .foregroundColor(Color(.white))
            .font(.system(size: 12, weight: .bold, design: .default))
            .cornerRadius(10)

            // Roomが見つかったかの判定
            if dataSource.resultState {
                Text("Roomが見つかりました！")
            } else {
                Text("")
            }
        }
        .padding(16)

        Spacer()
    }
}


extension HomePageView {
    class DataSource: ObservableObject {
        @Published var currentRoom: RoomOverview?
        @Published var showingAlert = false
        @Published var resultState = false
    }
}
