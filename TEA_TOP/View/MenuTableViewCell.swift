//
//  MenuTableViewCell.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2022/12/20.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet var drinkImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var lSizeLabel: UILabel!
    @IBOutlet var xlSizeLabel: UILabel!
    @IBOutlet var lPriceLabel: UILabel!
    @IBOutlet var xlPriceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
