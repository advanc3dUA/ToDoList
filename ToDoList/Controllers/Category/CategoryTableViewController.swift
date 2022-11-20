//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by Yuriy Gudimov on 20.11.2022.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    var categoryList = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        alert.addTextField { tf in
            tf.placeholder = "enter prefered category"
            textField = tf
        }
        
        let addAction = UIAlertAction(title: "Ok", style: .default) { action in
            guard textField.text != "" else { return }
            
            guard let entity = NSEntityDescription.entity(forEntityName: "Category", in: self.context) else { return }
            
            let newCategory = Category(entity: entity, insertInto: self.context)
            newCategory.name = textField.text
            self.categoryList.append(newCategory)
            self.saveCategories()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categoryList = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
}
