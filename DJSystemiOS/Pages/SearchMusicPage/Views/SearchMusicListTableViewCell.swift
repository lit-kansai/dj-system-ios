import UIKit

final class SearchMusicListTableViewCell: UITableViewCell {
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var musicNameLabel: UILabel! {
        didSet {
            musicNameLabel.textColor = .black
        }
    }
    @IBOutlet private var artistNameLabel: UILabel! {
        didSet {
            artistNameLabel.textColor = .systemGray
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(music: Music) {
        musicNameLabel.text = music.name
        artistNameLabel.text = music.artists
        Task {
            let image = await fetchImageData(from: music.thumbnail)
            DispatchQueue.main.async {
                self.thumbnailImageView.image = image
            }
        }
    }

    func fetchImageData(from url: URL) async -> UIImage {
        let defaultImage: UIImage = UIImage(systemName: "square.stack")!
        do {
            let (imageData, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            return UIImage(data: imageData) ?? defaultImage
        } catch {
            return defaultImage
        }
    }

}
