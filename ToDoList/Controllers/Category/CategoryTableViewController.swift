//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by Yuriy Gudimov on 20.11.2022.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    var categoryList: Results<Category>?
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: .none, preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { action in
            guard textField.text != "" else { return }
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addTextField { tf in
            tf.placeholder = "enter prefered category"
            textField = tf
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        categoryList = realm.objects(Category.self).sorted(byKeyPath: "name", ascending: true)
    }
}
