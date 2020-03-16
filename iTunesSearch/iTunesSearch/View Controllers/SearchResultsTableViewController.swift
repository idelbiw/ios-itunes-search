//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Waseem Idelbi on 3/15/20.
//  Copyright © 2020 WaseemID. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    //MARK: -IBOutlets-
    
    @IBOutlet var segmentController: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    let searchResultController = SearchResultController()
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = searchResultController.searchResults[indexPath.row].title
        cell.detailTextLabel?.text = searchResultController.searchResults[indexPath.row].creator
        return cell
    }

} //End of class

extension SearchResultsTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let textToSearch = searchBar.text else {return}
        var resultType: ResultType! {
            var selectedType: ResultType!
            if segmentController.selectedSegmentIndex == 0 {
                selectedType = .software
            } else if segmentController.selectedSegmentIndex == 1 {
                selectedType = .musicTrack
            } else if segmentController.selectedSegmentIndex == 2 {
                selectedType = .movie
            }
            return selectedType
        }
        searchResultController.performSearch(searchTerm: textToSearch, resultType: resultType) { (error) in
            guard error == nil else {
                print("Could not perform search, error: \(String(describing: error))")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
} //End of extension
