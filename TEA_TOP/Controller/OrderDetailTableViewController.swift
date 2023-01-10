//
//  OrderDetailTableViewController.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2023/1/10.
//

import UIKit

class OrderDetailTableViewController: UITableViewController {
    
    @IBOutlet var storeLabel: UILabel!
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    
    var orderDrinksInOrder: [OrderDrink]
    var order: Order
    
    init?(coder: NSCoder, orderDrinksInOrder: [OrderDrink], order: Order) {
        self.orderDrinksInOrder = orderDrinksInOrder
        self.order = order
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        var totalPrice: Int = 0
        var totalNumberOfCup: Int = 0
        for orderDrink in orderDrinksInOrder {
            totalPrice += orderDrink.numberOfCup * orderDrink.pricePerCup
            totalNumberOfCup += orderDrink.numberOfCup
        }
        totalPriceLabel.text = "$\(totalPrice)元 / \(totalNumberOfCup)杯"
        storeLabel.text = order.store
        dateLabel.text = order.date
        nameLabel.text = "訂購人：\(order.name)"
        phoneLabel.text = "聯絡電話：\(order.phone)"
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDrinksInOrder.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(OrderDetailTableViewCell.self)", for: indexPath) as! OrderDetailTableViewCell
        
        let orderDrink = orderDrinksInOrder[indexPath.row]
        
        cell.drinkImageView.image = UIImage(named: orderDrink.drink.name)
        cell.drinkNameLabel.text = orderDrink.drink.name
        var toppingString: String = ""
        for topping in orderDrink.toppings {
            toppingString += "/\(topping)"
        }
        cell.drinkDetailLabel.text = "\(orderDrink.size)/\(orderDrink.sugar)/\(orderDrink.temperature)\(toppingString)/$\(orderDrink.pricePerCup)"
        cell.numberOfCupLabel.text = "\(orderDrink.numberOfCup)杯"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
}
