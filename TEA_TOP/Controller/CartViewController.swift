//
//  CartViewController.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2023/1/4.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var totalNumberOfCupLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        updateTotalPrice()
    }
    
    func updateTotalPrice() {
        var totalPrice: Int = 0
        var totalNumberOfCup: Int = 0
        for orderDrink in orderDrinks {
            totalNumberOfCup += orderDrink.numberOfCup
            totalPrice += orderDrink.numberOfCup * orderDrink.pricePerCup
        }
        totalPriceLabel.text = "總金額：\(totalPrice)元"
        totalNumberOfCupLabel.text = "共\(totalNumberOfCup)杯"
    }
    
    @IBAction func unwindToCartView(_ segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCartInfoView" {
            let controller = segue.destination as! CartInfoViewController
            controller.totalPriceString = totalPriceLabel.text!
            controller.totalNumberOfCupString = totalNumberOfCupLabel.text!
        }
    }
    
    
    

    

}
