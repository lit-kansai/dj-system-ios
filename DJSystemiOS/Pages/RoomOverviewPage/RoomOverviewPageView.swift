import SwiftUI

struct RoomOverviewPageView: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("RoomOverview")
        }
    }
}

struct RoomOverviewPageView_Previews: PreviewProvider {
    static var previews: some View {
        RoomOverviewPageView()
    }
}
