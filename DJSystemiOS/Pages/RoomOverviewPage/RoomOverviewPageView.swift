import SwiftUI

struct RoomOverviewPageView: View {

    @Environment(\.dismiss) var dismiss
    weak var controller: RoomOverviewControllerProtocol?
    @ObservedObject var dataSource: DataSource

    init(controller: RoomOverviewControllerProtocol) {
        self.controller = controller
        self.dataSource = controller.state
    }

    var body: some View {
        VStack {
            Text(controller?.state.name ?? "")
                .foregroundColor(Color(.label))
                .font(.system(size: 34, weight: .bold, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)

            Text(controller?.state.description ?? "")
                .foregroundColor(Color(.label))
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 36)

            Button {
                Task {
                    controller?.toSearchMusicPage()
                }
            } label: {
                // ボタンのタップ領域をここで指定
                Text("曲をリクエストする")
                    .frame(maxWidth: .infinity, minHeight: 42)
            }
            .background(Color.pink)
            .foregroundColor(Color(.white))
            .font(.system(size: 12, weight: .bold, design: .default))
            .cornerRadius(10)
        }
        .padding(16)

        Spacer()
    }
}

extension RoomOverviewPageView {
    class DataSource: ObservableObject {
        @Published var name = ""
        @Published var description = ""
    }
}
