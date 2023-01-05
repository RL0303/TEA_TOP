//
//  SearchStoreTableViewController.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2023/1/5.
//

import UIKit

class SearchStoreTableViewController: UITableViewController {
    
    var filteredStores: [Store] = allStores

    override func viewDidLoad() {
        super.viewDidLoad()

        // add search controller
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false   // keep showing search bar when scrolling
        searchController.searchResultsUpdater = self
        
        getAllStoreData()
        // show all stores information as default
        filteredStores = allStores
    }

    

}

extension SearchStoreTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if searchText.isEmpty == false {
                filteredStores = allStores.filter({ store in
                    let isContainedInName = store.name.localizedStandardContains(searchText)
                    let isContainedInAddress = store.address.localizedStandardContains(searchText)
                    if isContainedInName || isContainedInAddress {
                        return true
                    } else {
                        return false
                    }
                })
            } else {
                filteredStores = allStores
            }
            tableView.reloadData()
        }
    }
}
