//
//  MenuViewController.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2022/12/20.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var categoryButtons: [UIButton]!
    
    var drinks: [Drink] = []
    var currentButtonIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    
    
    // MARK: - Fetch data (get menu data from AirTable)
    func fetchDrinkData(){
        showLoadingView()
        let urlString = "https://api.airtable.com/v0/\(appId)/Menu?api_key=\(apiKey)"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let drinkData: DrinkData = decodeJsonData(data)
                    self.covertDrinkDataToDrink(drinkData)
                    DispatchQueue.main.async {
                        self.getDrinks(category: "嚼對推薦")
                        self.tableView.reloadData()
                        // dismiss LoadingViewController
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }.resume()
        }
    }
    
    func covertDrinkDataToDrink(_ drinkData: DrinkData) {
        for record in drinkData.records {
            let L: Int? = record.fields.priceL
            let XL: Int? = record.fields.priceXL
            let newDrink = Drink(
                name: record.fields.name,
                priceL: L,
                priceXL: XL,
                noCaffeine: record.fields.noCaffeine == "TRUE" ? true : false,
                description: record.fields.description,
                category: record.fields.category
            )
            allDrinks += [newDrink]
        }
    }
    
    func showLoadingView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "LoadingViewController")
        secondVC.modalPresentationStyle = .overFullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        present(secondVC, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - TableView
extension MenuViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MenuTableViewCell.self)", for: indexPath) as! MenuTableViewCell
        let drink = drinks[indexPath.row]
        
        cell.drinkImageView.image = UIImage(named: "招牌高山青") //drink.name)
        cell.nameLabel.text = drink.name
        
        // Check if the drink has L size option
        if drink.priceL != nil {
            cell.lPriceLabel.isHidden = false
            cell.lSizeLabel.isHidden = false
            cell.lPriceLabel.text = "\(drink.priceL!)"
        } else {
            cell.lPriceLabel.isHidden = true
            cell.lSizeLabel.isHidden = true
        }
        
        // Check if the drink has XL size option
        if drink.priceXL != nil {
            cell.xlPriceLabel.isHidden = false
            cell.xlSizeLabel.isHidden = false
            cell.xlPriceLabel.text = "\(drink.priceXL!)"
        } else {
            cell.xlPriceLabel.isHidden = true
            cell.xlSizeLabel.isHidden = true
        }
        
        return cell
    }
}
