//
//  SearchBar+ToDoListVC.swift
//  ToDoList
//
//  Created by Yuriy Gudimov on 19.11.2022.
//

import Foundation
import UIKit

extension ToDoListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       searchAndSortItems(for: searchBar)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            searchAndSortItems(for: searchBar)
        }
    }
    
    fileprivate func searchAndSortItems(for searchBar: UISearchBar) {
        let searchQuery: String
        searchQuery = searchBar.text!
        guard searchQuery != "" else { return }

        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchQuery).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }
}
