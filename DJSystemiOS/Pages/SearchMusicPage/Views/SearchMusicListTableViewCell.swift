import UIKit

final class SearchMusicListTableViewCell: UITableViewCell {
    static let height: CGFloat = 64
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var musicNameLabel: UILabel! {
        didSet {
            musicNameLabel.textColor = .label
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

    func configureCell(_ data: SearchMusicListTableViewCell.Data) {
        musicNameLabel.text = data.musicName
        artistNameLabel.text = data.artistName
        thumbnailImageView.image = data.thumbnail
    }

}

extension SearchMusicListTableViewCell {
    struct Data {
        let thumbnail: UIImage
        let musicName: String
        let artistName: String
    }
}
