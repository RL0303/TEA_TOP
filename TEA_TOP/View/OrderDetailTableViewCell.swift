//
//  OrderDetailTableViewCell.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2023/1/10.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {
    
//    @IBOutlet var customerNameLabel: UILabel!
    @IBOutlet var drinkImageView: UIImageView!
    @IBOutlet var drinkNameLabel: UILabel!
    @IBOutlet var drinkDetailLabel: UILabel!
    @IBOutlet var numberOfCupLabel: UILabel!
    
//    @IBOutlet var viewTopContraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
