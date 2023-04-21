import SwiftUI
import UIKit
import PKHUD

protocol HomePageControllerProtocol: AnyObject {
    func searchRoom(byId id: String) async throws
    var state: HomePageView.DataSource { get set }
}

final class HomePageViewController: UIViewController {
    @ObservedObject var state: HomePageView.DataSource = .init()
    // TODO: 後でletに変える
    var roomAPI: GetRoomAPIProtocol = Room.API()

    init(roomAPI: GetRoomAPIProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.roomAPI = roomAPI
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.roomAPI = Room.API()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let homePage = HomePageView(controller: self)
        let hostingVC = UIHostingController(rootView: homePage)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
        hostingVC.coverView(parent: view)
    }
}

extension HomePageViewController: HomePageControllerProtocol {
    func searchRoom(byId id: String) async throws {
        do {
            // ローディング開始
            HUD.show(.progress)
            // Roomの存在確認
            let roomOverview = try await roomAPI.getRoom(id: id)
            // RoomIdが空でないとき
            if !roomOverview.id.isEmpty {
                Task.detached { @MainActor [state] in
                    // 取得したRoomOverviewを渡す
                    state.currentRoom = roomOverview
                    // 表示結果を表示する
                    state.showResultText = true
                    // アラートを非表示する
                    state.shouldShowAlert = false
                }
                self.navigationController?.pushViewController(RoomOverviewViewController(roomOverview: roomOverview), animated: true)
                // ローディング終了
                HUD.flash(.success, delay: 1.0)
            // RoomIdがからの時(""の時)
            } else {
                Task.detached { @MainActor [state] in
                    // 空のRoomOverviewを渡す
                    state.currentRoom = RoomOverview(id: "", name: "", description: "")
                    // 表示結果を非表示にする
                    state.showResultText = false
                    // アラートを表示する
                    state.shouldShowAlert = true
                }
                // ローディング終了
                HUD.hide()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

