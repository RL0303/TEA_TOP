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
        self.isModalInPresentation = true
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

// MARK: - TableView
extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDrinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CartTableViewCell.self)", for: indexPath) as! CartTableViewCell
        
        cell.delagate = self
        
        let orderDrink = orderDrinks[indexPath.row]
        cell.valueUpButton.tag = indexPath.row
        cell.valueDownButton.tag = indexPath.row
        cell.drinkImageView.image = UIImage(named: "招牌高山青") //orderDrink.drink.name
        cell.drinkNameLabel.text = orderDrink.drink.name
        var toppingString: String = ""
        for topping in orderDrink.toppings {
            toppingString += "/\(topping)"
        }
        cell.drinkDetailLabel.text = "\(orderDrink.size)/\(orderDrink.sugar)/\(orderDrink.temperature)\(toppingString)/$\(orderDrink.pricePerCup)"
        cell.numberOfCupLabel.text = "\(orderDrink.numberOfCup)杯"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        orderDrinks.remove(at: indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
        updateTotalPrice()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
}

// MARK: - TableViewCellDelegate
extension CartViewController: CartTableViewCellDelegate {
    func didTapValueDownButton(with cellIndex: Int) {
        if orderDrinks[cellIndex].numberOfCup > 1 {
            orderDrinks[cellIndex].numberOfCup -= 1
            updateTotalPrice()
            let indexPath = IndexPath(row: cellIndex, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func didTapValueUpButton(with cellIndex: Int) {
        if orderDrinks[cellIndex].numberOfCup < 99 {
            orderDrinks[cellIndex].numberOfCup += 1
            updateTotalPrice()
            let indexPath = IndexPath(row: cellIndex, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
