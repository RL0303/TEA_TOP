//
//  CartInfoViewController.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2023/1/5.
//

import UIKit

class CartInfoViewController: UIViewController {

    var order = Order(orderNo: "", name: "", phone: "", store: "", date: "", memo: "")
    
    var totalPriceString: String = ""
    var totalNumberOfCupString: String = ""

    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var totalNumberOfCupLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalPriceLabel.text = totalPriceString
        totalNumberOfCupLabel.text = totalNumberOfCupString
    }
    

    @IBAction func orderButtonPressed(_ sender: UIButton) {
        if order.name == "" {
            showAlert(message: "請輸入訂購人姓名")
        } else if order.phone == "" {
            showAlert(message: "請輸入聯絡電話")
        } else if order.store == "" {
            showAlert(message: "請選擇取貨門市")
        } else {
//            uploadOrder(order: order)
        }
    }
    
    @IBAction func unwindToCartInfoView(_ segue: UIStoryboardSegue) {
        
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "欄位錯誤", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}
