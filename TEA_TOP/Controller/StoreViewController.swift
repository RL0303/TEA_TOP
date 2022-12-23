//
//  StoreViewController.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2022/12/22.
//

import UIKit

class StoreViewController: UIViewController {
    
    let areaList: [String: [String]] = [
        "北部": ["台北", "新北", "桃園", "宜蘭"],
        "中部": ["苗栗", "台中", "彰化", "南投", "雲林"],
        "南部": ["嘉義", "台南", "高雄", "屏東"]
    ]
    
    var stores: [Store] = []
    var currentAreaButton: UIButton?
    
    @IBOutlet var teatopImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var areaButtons: [UIButton]!
    
    @IBOutlet var locationButtons: [UIButton]!
    @IBOutlet var locationView: UIView!
    @IBOutlet var locationScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        locationScrollView.isHidden = true
        getAllStoreData()
        stores = allStores
        tableView.isHidden = true
    }
    
    // MARK: - Location Button Pressed
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        teatopImageView.isHidden = true
        tableView.isHidden = false
        let location = sender.titleLabel!.text!
        getStores(location: location)
        changeButtonStatus(buttons: locationButtons, selectedButton: sender)
        
        // scroll to the top of table view
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func getStores(location: String) {
        stores = []
        for store in allStores {
            if store.name.contains(location) {
                stores += [store]
            }
        }
        tableView.reloadData()
    }
    
    // MARK: - Area Button Pressed
    @IBAction func areaButtonPressed(_ sender: UIButton) {
        changeButtonStatus(buttons: areaButtons, selectedButton: sender)
        // scroll to the top of table view
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        tableView.isHidden = false
        teatopImageView.isHidden = true
        
        if sender == currentAreaButton {
            locationScrollView.isHidden.toggle()
        } else {
            locationScrollView.isHidden = false
            let area = sender.titleLabel!.text!
            if let locations = areaList[area] {
                print(locationButtons.count, locations.count)
                for idx in 0..<locationButtons.count {
                    if idx < locations.count {
                        locationButtons[idx].isHidden = false
                        locationButtons[idx].setTitle(locations[idx], for: .normal)
                        print("show", idx)
                    } else {
                        locationButtons[idx].isHidden = true
                        print("hide",idx)
                    }
                }

                locationScrollView.setContentOffset(CGPoint(x:0, y: 0), animated: false)
                changeButtonStatus(buttons: locationButtons, selectedButton: locationButtons[0])
                getStores(location: locations[0])
                
            }
            currentAreaButton = sender
        }
    }

    // MARK: - Change Button Status
    func changeButtonStatus(buttons: [UIButton], selectedButton: UIButton) {
        for button in buttons {
            button.configuration?.baseBackgroundColor = UIColor(named: "teatopblue")
            button.configuration?.baseForegroundColor = .white //UIColor(named: "green3")
        }
        selectedButton.configuration?.baseBackgroundColor = UIColor(named:"teatop")
        selectedButton.configuration?.baseForegroundColor = .black
    }

}

// MARK: - Table View
extension StoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(StoreTableViewCell.self)", for: indexPath) as! StoreTableViewCell
        let store = stores[indexPath.row]
        cell.nameLabel.text = store.name
        cell.addressLabel.text = store.address
        cell.phoneLabel.text = store.phone
        cell.openingHoursLabel.text = store.openingHours
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let mapUrl = stores[indexPath.row].mapUrl {
            UIApplication.shared.open(mapUrl)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    
}
