//
//  SearchBar+ToDoListVC.swift
//  ToDoList
//
//  Created by Yuriy Gudimov on 19.11.2022.
//

import Foundation
import UIKit
import CoreData

extension ToDoListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchQuery: String
        searchQuery = searchBar.text!
        guard searchQuery != "" else { return }
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()

        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchQuery)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
