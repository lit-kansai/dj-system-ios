import PKHUD
import SwiftUI
import UIKit

protocol SearchRoomViewControllerProtocol: Transitioner {
    var state: SearchRoomPageView.DataSource { get set }
    func searchRoom(byId id: String) async
}

final class SearchRoomViewController: UIViewController {
    var state: SearchRoomPageView.DataSource = .init()

    private let roomAPI: GetRoomAPIProtocol
    private let router: SearchRoomRouterProtocol

    init(roomAPI: GetRoomAPIProtocol, router: SearchRoomRouterProtocol) {
        self.roomAPI = roomAPI
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clearState()
    }

}

// MARK: UI
extension SearchRoomViewController {
    private func presentErrorAlert(title: String = "エラーが発生しました", message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    private func setupUI() {
        let homePage = SearchRoomPageView(controller: self, dataSource: self.state)
        let hostingVC = UIHostingController(rootView: homePage)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
        hostingVC.coverView(parent: view)

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "ルームを探す"
    }

}

// MARK: State
extension SearchRoomViewController {
    private func clearState() {
        state.currentRoom = .init(id: "", name: "", description: "")
        state.searchQuery = ""
        state.showResultText = false
    }
}

// MARK: SearchRoomViewControllerProtocol
extension SearchRoomViewController: SearchRoomViewControllerProtocol {
    func searchRoom(byId id: String) async {
        // ローディング開始
        HUD.show(.progress)
        // レスポンス取得
        let result = await roomAPI.getRoom(id: id)
        switch result {
        // Roomが見つかった時
        case .success(let response):
            let roomOverview = RoomOverview(id: response.id, name: response.name, description: response.description)
            state.currentRoom = roomOverview
            state.showResultText = true
            // Routerを使った画面遷移
            guard let navigationController = self.navigationController else { return }
            router.transitionToRoomOverviewPage(navigationController, roomOverview: roomOverview)
        // Roomが見つからなかった時
        case .failure(let error):
            if case .httpError(let httpError) = error, case .notFound = httpError {
                presentErrorAlert(title: "ルームが見つかりませんでした", message: "IDが間違っていないか確認してください")
                break
            }
        presentErrorAlert(message: error.localizedDescription)
        }
        HUD.hide()
    }

}

