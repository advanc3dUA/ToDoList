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
    
    func saveItems() {
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
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.searchBar.endEditing(true)
//    }
}
