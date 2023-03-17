//
//  SearchMusicListTableViewCell.swift
//  DJSystemiOS
//
//  Created by Atsuhiro Muroyama on 2023/03/13.
//

import UIKit

class SearchMusicListTableViewCell: UITableViewCell {
    @IBOutlet var haikeiImageView: UIImageView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        musicNameLabel.textColor = UIColor(hex: "FAFAFA")
        artistNameLabel.textColor = UIColor(hex: "A6A6A6")
    }
}
