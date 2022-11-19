//
//  ToDoListTableViewController.swift
//  TodoList
//
//  Created by Yuriy Gudimov on 16.11.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class ToDoListTableViewController: UITableViewController {
    
    var itemList = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemList[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemList[indexPath.row].done = !itemList[indexPath.row].done
        saveItems()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {[unowned self] _,_,_ in
            context.delete(itemList[indexPath.row])
            itemList.remove(at: indexPath.row)
            saveItems()
            tableView.reloadData()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])

        return swipeActions
    }

    // MARK: - Add new item section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new task", message: .none, preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) { action in
            
            guard let entity = NSEntityDescription.entity(forEntityName: "Item", in: self.context) else { return }
            let newItem = Item(entity: entity, insertInto: self.context)
            newItem.title = textField.text
            newItem.done = false
            
            self.itemList.append(newItem)
            
            self.saveItems()
            
            self.tableView.reloadData()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { addTextField in
            addTextField.placeholder = "enter new task here"
            textField = addTextField
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    //MARK: - Model manipulation methods
    
    fileprivate func saveItems() {
        do {
            try context.save()
        } catch {
            print("error saving to db: \(error.localizedDescription)")
        }
    }
    
    fileprivate func loadItems() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemList = try context.fetch(request)
        } catch {
            print("error reading from db: \(error.localizedDescription)")
        }
    }
}
