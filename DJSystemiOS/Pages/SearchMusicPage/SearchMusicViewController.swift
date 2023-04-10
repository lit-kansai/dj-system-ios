import SnapKit
import UIKit

class SearchMusicViewController: UIViewController {
    let searchMusicSearchBar = UISearchBar()
    let searchMusicTableView = UITableView()

    var searchWord: String = ""

    var musics: [Music] = [] {
        didSet {
            searchMusicTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchMusicSearchBar.delegate = self
        searchMusicTableView.delegate = self
        searchMusicTableView.dataSource = self

        setUpUI()
        searchMusicTableView.register(UINib(nibName: "SearchMusicListTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }

    func setUpUI() {
        searchMusicSearchBar.barTintColor = UIColor(hex: "1E1E1E")
        searchMusicSearchBar.backgroundColor = UIColor(hex: "1E1E1E")
        searchMusicSearchBar.searchTextField.textColor = UIColor(hex: "EBEBF5", alpha: 0.6)
        view.addSubview(searchMusicSearchBar)
        searchMusicSearchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }

        view.addSubview(searchMusicTableView)
        searchMusicTableView.snp.makeConstraints {
            $0.top.equalTo(searchMusicSearchBar.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    func fetchSearchedMusic() async throws -> ([Music]) {
        Task {
            let decoder: JSONDecoder = {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return decoder
            }()
            let encodingSearchWord = searchWord.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            let requestUrl = URL(string: "https://dj-api.life-is-tech.com/room/sample-gassi/music/search?q=\(encodingSearchWord!))")
            let urlRequest = URLRequest(url: requestUrl!)
            do {
                let (data, _) = try await URLSession.shared.data(for: urlRequest)
                let music = try decoder.decode([Music].self, from: data)
                musics = music
            } catch {
                doAPIErrorAlert()
            }
        }
        return musics
    }

    func doAPIErrorAlert() {
        let alert = UIAlertController(title: "検索失敗", message: "検索することができませんでした", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    func doSearchBarErrorAlert() {
        let alert = UIAlertController(title: "取得失敗", message: "検索バーの言葉を取得できませんでした。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}



extension SearchMusicViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let searchWord = searchBar.text {
            self.searchWord = searchWord
            Task {
                do {
                    musics = try await fetchSearchedMusic()
                    searchMusicTableView.reloadData()
                } catch {
                    doSearchBarErrorAlert()
                }
            }
        }
    }
}

extension SearchMusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
}

extension SearchMusicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchMusicListTableViewCell
        cell.setData(music: musics[indexPath.row])
        return cell
    }
}
