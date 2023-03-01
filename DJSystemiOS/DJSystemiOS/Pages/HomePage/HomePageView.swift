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
            TextField("部屋を検索しよう！", text: $dataSource.searchQuery)
            Button("searchRoom") {
                Task { await controller?.searchRoom(byId: dataSource.searchQuery) }
            }
            if let currentRoom = dataSource.currentRoom {
                Text("id: \(currentRoom.id)")
                Text("name: \(currentRoom.name)")
                Text("description: \(currentRoom.description)")
            }
        }
        .padding(16)
    }
}


extension HomePageView {
    class DataSource: ObservableObject {
        @Published var searchQuery = "ddd"
        @Published var currentRoom: RoomOverview?
    }
}
