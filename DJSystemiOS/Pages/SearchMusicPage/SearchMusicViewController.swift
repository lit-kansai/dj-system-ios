import UIKit



class SearchMusicViewController: UIViewController {
    @IBOutlet private weak var searchMusicTableView: UITableView!
    @IBOutlet private weak var searchMusicSearchBar: UISearchBar!

    var searchWord: String?

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

        searchMusicTableView.register(UINib(nibName: "SearchMusicListTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    
        searchMusicSearchBar.barTintColor = UIColor(hex: "1E1E1E")
        searchMusicSearchBar.backgroundColor = UIColor(hex: "1E1E1E")
        searchMusicSearchBar.searchTextField.textColor = UIColor(hex: "EBEBF5", alpha: 0.6)
    }

    func fetchSearchedMusic() async throws -> ([Music]) {
        Task {
            let decoder: JSONDecoder = {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return decoder
            }()
            let encodingSearchWord = searchWord!.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            let requestUrl = URL(string: "https://dj-api.life-is-tech.com/room/sample-gassi/music/search?q=\(encodingSearchWord!))")!
            let urlRequest = URLRequest(url: requestUrl)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let music = try! decoder.decode([Music].self, from: data)

            musics = music
        }
        return musics
    }
}

extension SearchMusicViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let searchWord = searchBar.text {
            self.searchWord = searchWord

            Task {
                musics = try! await fetchSearchedMusic()
                searchMusicTableView.reloadData()
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
        cell.musicNameLabel?.text = musics[indexPath.row].name
        cell.artistNameLabel?.text = musics[indexPath.row].artists
        cell.haikeiImageView.backgroundColor = UIColor(hex: "1E1E1E")
        Task {
            let (imageData, _) = try await URLSession.shared.data(for: URLRequest(url: musics[indexPath.row].thumbnail))
            cell.thumbnailImageView.image = UIImage(data: imageData)
        }
        return cell
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}
extension UISearchBar {
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return searchTextField
        } else {
            return value(forKey: "_background") as? UITextField
        }
    }
}
