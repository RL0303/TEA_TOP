//
//  StoreViewController.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2022/12/22.
//

import UIKit

class StoreViewController: UIViewController {
    
    let areaList: [String: [String]] = [
        "北部": ["臺北", "新北", "桃園", "宜蘭"],
        "中部": ["苗栗", "臺中", "彰化", "南投", "雲林"],
        "南部": ["嘉義", "臺南", "高雄", "屏東"]
    ]
    
    var stores: [Store] = []
    var currentAreaButton: UIButton?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var areaButtons: [UIButton]!
    
    @IBOutlet var locationButtons: [UIButton]!
    @IBOutlet var locationView: UIView!
    @IBOutlet var locationScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    
}
