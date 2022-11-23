//
//  TableView+CategoryTableVC.swift
//  ToDoList
//
//  Created by Yuriy Gudimov on 20.11.2022.
//

import UIKit

extension CategoryTableViewController {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
    
        var content = cell.defaultContentConfiguration()
        content.text = categoryList?[indexPath.row].name ?? "No categories added yet"
        cell.contentConfiguration = content
     
        return cell
     }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _,_,_ in
            if let category = self.categoryList?[indexPath.row] {
                do {
                    try self.realm.write {
                        self.realm.delete(category)
                        tableView.reloadData()
                    }
                } catch {
                    print("error deleting category, \(error.localizedDescription)")
                }
            }
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryList?[indexPath.row]
        }
    }
}
