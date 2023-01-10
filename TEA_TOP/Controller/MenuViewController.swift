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
        
        
        // get default category
        changeCategoryButtonStatus(selectedButton: categoryButtons[0])
        
        // swipe left/right to change category
        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        swipeLeftGestureRecognizer.direction = .left
        swipeRightGestureRecognizer.direction = .right
        tableView.addGestureRecognizer(swipeLeftGestureRecognizer)
        tableView.addGestureRecognizer(swipeRightGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // get menu data from AirTable
        if allDrinks == [] {
            fetchDrinkData()
        }
    }
    
    // MARK: - Swipe left/right to change category
    @IBAction func swipeLeft() {
        if currentButtonIndex < categoryButtons.count-1 {
            currentButtonIndex += 1
            categoryButtonPressed(categoryButtons[currentButtonIndex])
        }
    }
    @IBAction func swipeRight() {
        if currentButtonIndex >= 1 {
            currentButtonIndex -= 1
            categoryButtonPressed(categoryButtons[currentButtonIndex])
        }
    }
    
    // MARK: - Segue
    
    @IBSegueAction func showMenuDetail(_ coder: NSCoder) -> MenuDetailViewController? {
        return MenuDetailViewController(coder: coder, drink: drinks[tableView.indexPathForSelectedRow!.row])
    }
    
    @IBAction func unwindToMenuView(_ segue: UIStoryboardSegue) {
        
    }
    
    
    // MARK: - Category Button
    
    @IBAction func categoryButtonPressed(_ sender: UIButton){
        
        // show menu of selected category
        let category = sender.titleLabel!.text!
        getDrinks(category: category)
        
        // change style of buttons (selected/unselected)
        currentButtonIndex = sender.tag
        changeCategoryButtonStatus(selectedButton: sender)
        
        // let selected button scroll to middle
        let scrollLimit = scrollView.contentSize.width - scrollView.frame.width
        let xOffset = sender.center.x - scrollView.frame.width/2
//        print(scrollLimit, xOffset)
        if xOffset < 0 {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        } else if xOffset > scrollLimit {
            scrollView.setContentOffset(CGPoint(x: scrollLimit, y: 0), animated: true)
        } else {
            scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
        }
        
        // scroll to the top of table view
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    
    func changeCategoryButtonStatus(selectedButton: UIButton) {
        for button in categoryButtons {
            button.configuration?.cornerStyle = .capsule
            button.configuration?.background.strokeWidth = 1.5
            button.configuration?.background.strokeColor = UIColor(named:"teatopblue")
            button.configuration?.baseBackgroundColor = .white
            button.configuration?.baseForegroundColor = UIColor(named: "teatopblue")
        }
        
        selectedButton.configuration?.baseBackgroundColor =  UIColor(named:"teatopblue")
        selectedButton.configuration?.baseForegroundColor = .white
    }
    
    // MARK: - Display menu of selected category in table view
    func getDrinks(category: String) {
        drinks = []
        for drink in allDrinks {
            if drink.category == category {
                drinks += [drink]
            }
        }
        tableView.reloadData()
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
                        self.getDrinks(category: "第一味青茶系")
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MenuTableViewCell.self)", for: indexPath) as! MenuTableViewCell
        let drink = drinks[indexPath.row]
        
        cell.drinkbackgroundView.layer.cornerRadius = 15
        cell.drinkbackgroundView.layer.borderWidth = 2
        cell.drinkbackgroundView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        cell.drinkbackgroundView.backgroundColor = .white
        cell.drinkImageView.image = UIImage(named: drink.name)
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
