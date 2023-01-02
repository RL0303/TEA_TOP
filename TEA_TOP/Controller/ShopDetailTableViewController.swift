//
//  ShopDetailTableViewController.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2023/1/2.
//

import UIKit

class ShopDetailTableViewController: UITableViewController {
    
    var drink: Drink
    var orderDrink: OrderDrink {
        didSet {
            performSegue(withIdentifier: "unwindToShopDetailView", sender: nil)
        }
    }
    
    var selectedToppingButtons: [UIButton] = []
    
//    @IBOutlet var customerNameTextField: UITextField!
    @IBOutlet var sizeButtons: [UIButton]!
    @IBOutlet var temperatureButtons: [UIButton]!
    @IBOutlet var sugarButtons: [UIButton]!
    @IBOutlet var toppingButtons: [UIButton]!
    
    @IBOutlet var imageView: UIImageView!
    
    init?(coder: NSCoder, drink: Drink, orderDrink: OrderDrink) {
        self.drink = drink
        self.orderDrink = orderDrink
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    


}
