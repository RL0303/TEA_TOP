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
//            print("performSegue")
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
        updateUI()
//        print("detail table")
    }
    
    func updateUI() {
        imageView.image = UIImage(named: drink.name)
        
        if drink.priceL == nil {
            sizeButtons[0].isHidden = true
            sizeButtonPressed(sizeButtons[1])
        } else if drink.priceXL == nil {
            sizeButtons[1].isHidden = true
            sizeButtonPressed(sizeButtons[0])
        } else {
            sizeButtonPressed(sizeButtons[0])
        }
        
        // Temperature Option
        changeButtonStatus(buttons: temperatureButtons, selectedButtons: [temperatureButtons[0]])
        
        // Sugar Option
        changeButtonStatus(buttons: sugarButtons, selectedButtons: [sugarButtons[0]])
        
    }
    
    // MARK: - Buttons
    @IBAction func sizeButtonPressed(_ sender: UIButton) {
        changeButtonStatus(buttons: sizeButtons, selectedButtons: [sender])
        let size = sender.titleLabel!.text!
        orderDrink.size = size == "L" ? "L" : "XL"
        
    }
    
    @IBAction func temperatureButtonPressed(_ sender: UIButton) {
        orderDrink.temperature = temperatureList[sender.tag]
        changeButtonStatus(buttons: temperatureButtons, selectedButtons: [sender])
    }
    
    @IBAction func sugarButtonPressed(_ sender: UIButton) {
        orderDrink.sugar = sugarList[sender.tag]
        changeButtonStatus(buttons: sugarButtons, selectedButtons: [sender])
    }
    
    @IBAction func toppingButtonPressed(_ sender: UIButton) {
        if selectedToppingButtons.contains(sender) {
            selectedToppingButtons.removeAll(where: { $0 == sender} )
        } else {
            if selectedToppingButtons.count >= 2 {
                selectedToppingButtons = []
            }
            selectedToppingButtons += [sender]
        }
        
        orderDrink.toppings = []
        for toppingButton in selectedToppingButtons {
            let topping = toppingButton.titleLabel!.text!
            orderDrink.toppings += [topping]
        }
        changeButtonStatus(buttons: toppingButtons, selectedButtons: selectedToppingButtons)
    }
    
    func changeButtonStatus(buttons: [UIButton], selectedButtons: [UIButton]) {
        for button in buttons {
            button.configuration?.baseBackgroundColor = UIColor(named: "teatopblue")
            button.configuration?.baseForegroundColor = .white
        }
        for button in selectedButtons {
            button.configuration?.baseBackgroundColor = UIColor(named:"teatop")
            button.configuration?.baseForegroundColor = .black
        }
        
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToShopDetailView" {
//            print("prepare")
            let controller = segue.destination as! ShopDetailViewController
            controller.orderDrink = orderDrink
            
        }
    }
}
