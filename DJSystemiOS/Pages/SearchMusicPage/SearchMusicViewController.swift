import PKHUD
import SnapKit
import UIKit

final class SearchMusicViewController: UIViewController, Transitioner {
    private let searchBar = UISearchBar()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(R.nib.searchMusicListTableViewCell)
        tableView.separatorStyle = .none
        return tableView
    }()

    private let roomId: String
    private let roomAPI: SearchMusicProtocol
    private let router: SearchMusicRouterProtocol

    private var searchQuery: String = ""
    private var musics: [Music] = []
    private var images: [URL: UIImage] = [:]

    private let defaultThumbnailImage = UIImage(systemName: "square.stack")!

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(roomId: String, roomAPI: SearchMusicProtocol, router: SearchMusicRouterProtocol) {
        self.roomId = roomId
        self.roomAPI = roomAPI
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.removeViewController(preserving: CooltimeViewController.self, animated: true)
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        setUpUI()
    }

    private func searchMusic(with query: String, roomId: String) async {
        HUD.show(.progress)
        let inputs: Room.API.SearchMusicInputs = .init(roomId: roomId, query: query)
        let searchMusicResult = await roomAPI.searchMusic(inputs: inputs)

        switch searchMusicResult {
        case .success(let _musics):
            musics = _musics
            images = await ImageLoader.fetchImages(from: musics.map { $0.thumbnail })
                .mapValues { $0 ?? defaultThumbnailImage }
            tableView.reloadData()
        case .failure(let error):
            presentAPIErrorAlert(message: error.localizedDescription)
        }

        HUD.hide()
    }

    private func presentAPIErrorAlert(title: String = "エラーが発生しました", message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: UISearchBarDelegate
extension SearchMusicViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        guard let text = searchBar.text else { return }
        searchQuery = text
        Task {
            await searchMusic(with: searchQuery, roomId: roomId)
        }
    }
}

// MARK: UITableViewDelegate
extension SearchMusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchMusicListTableViewCell.height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nc = navigationController else { return }
        router.transitionToRequestMusicPage(nc, roomId: roomId, music: musics[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: UITableViewDataSource
extension SearchMusicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.searchMusicListTableViewCell, for: indexPath)
        guard let cell = cell else { fatalError("Invalid TableViewCell") }

        let music = musics[indexPath.row]
        let thumbnail = images[music.thumbnail] ?? defaultThumbnailImage
        cell.configureCell(.init(thumbnail: thumbnail, musicName: music.name, artistName: music.artists))
        return cell
    }
}

// MARK: UI
extension SearchMusicViewController {
    private func setUpUI() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "曲を探す"
    }

}
