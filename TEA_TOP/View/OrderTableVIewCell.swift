//
//  OrderTableVIewCell.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2023/1/10.
//

import UIKit

class OrderTableVIewCell: UITableViewCell {
    
    @IBOutlet var storeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
