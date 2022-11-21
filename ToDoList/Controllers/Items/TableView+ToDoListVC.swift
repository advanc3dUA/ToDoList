//
//  TableView+ToDoListVC.swift
//  ToDoList
//
//  Created by Yuriy Gudimov on 19.11.2022.
//

import UIKit

extension ToDoListTableViewController {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = itemList?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = itemList?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("error saving done status, \(error.localizedDescription)")
            }
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {[unowned self] _,_,_ in
            if let item = itemList?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(item)
                        tableView.reloadData()
                    }
                } catch {
                    print("error deleting item, \(error.localizedDescription)")
                }
            }
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
