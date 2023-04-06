import UIKit

class SearchMusicListTableViewCell: UITableViewCell {
    @IBOutlet private var backgroundImageView: UIImageView!
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var musicNameLabel: UILabel!
    @IBOutlet private var artistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        musicNameLabel.textColor = UIColor(hex: "FAFAFA")
        artistNameLabel.textColor = UIColor(hex: "A6A6A6")
    }
    
    func setData(music: Music) {
        musicNameLabel.text = music.name
        artistNameLabel.text = music.artists
        backgroundImageView.backgroundColor = UIColor(hex: "1E1E1E")
        Task {
            let (imageData, _) = try await URLSession.shared.data(for: URLRequest(url: music.thumbnail))
            thumbnailImageView.image = UIImage(data: imageData)
        }
    }
}
