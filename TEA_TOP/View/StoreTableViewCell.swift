//
//  StoreTableViewCell.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2022/12/22.
//

import UIKit

class StoreTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var openingHoursLabel: UILabel!
    
    @IBOutlet var addressImageView: UIImageView! {
        didSet {
            addressImageView.image = UIImage(named: "place")?.withRenderingMode(.alwaysTemplate)
            addressImageView.tintColor = UIColor(named: "teatop")
        }
    }
    @IBOutlet var phoneImageView: UIImageView!
    @IBOutlet var openingHoursImageView: UIImageView! {
        didSet {
            openingHoursImageView.image = UIImage(named: "time")?.withRenderingMode(.alwaysTemplate)
            openingHoursImageView.tintColor = UIColor(named: "teatop")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
