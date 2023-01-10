//
//  MenuDetailViewController.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2022/12/22.
//

import UIKit

class MenuDetailViewController: UIViewController {
    
    var drink: Drink
    
    init?(coder: NSCoder, drink: Drink) {
        self.drink = drink
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var lLabel: UILabel!
    @IBOutlet var xlLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var noCaffeineLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        // Tap screen to go back to the previous page
        addTapRecognizer()
    }
    
    // MARK: - Update View
    func updateView() {
        imageView.image = UIImage(named: drink.name)
        nameLabel.text = drink.name
        if drink.priceL == nil {
            lLabel.isHidden = true
        }
        if drink.priceXL == nil {
            xlLabel.isHidden = true
        }
        
        lLabel.layer.masksToBounds = true
        lLabel.layer.cornerRadius = 25
        xlLabel.layer.masksToBounds = true
        xlLabel.layer.cornerRadius = 25
        
        descriptionTextView.layer.cornerRadius = 15
        descriptionTextView.text = drink.description
        
        noCaffeineLabel.layer.masksToBounds = true
        noCaffeineLabel.layer.cornerRadius = 20
        noCaffeineLabel.isHidden = drink.noCaffeine ? false : true
    }
    
    // MARK: - Tap screen to go back to the previous page
    func addTapRecognizer() {
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(MenuDetailViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func didTapView() {
        self.performSegue(withIdentifier: "unwindToMenuView", sender: self)
    }

}
