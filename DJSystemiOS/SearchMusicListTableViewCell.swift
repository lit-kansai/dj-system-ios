//
//  SearchMusicListTableViewCell.swift
//  DJSystemiOS
//
//  Created by Atsuhiro Muroyama on 2023/03/13.
//

import UIKit

class SearchMusicListTableViewCell: UITableViewCell {
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
