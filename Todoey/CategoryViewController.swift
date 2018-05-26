//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Joseph Anthony Castillon on 5/15/18.
//  Copyright © 2018 Joseph Anthony Castillon. All rights reserved.
//

import UIKit
import CoreData
import SwipeCellKit

class CategoryViewController: UITableViewController {
    
    
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataFilePath = FileManager.default.urls(for: .documentDirectory
                    , in: .userDomainMask).first?.appendingPathComponent("TodoeyItems.plist")
        print("Data file path:  \(dataFilePath!)")

        loadCategories()
    }

    
    //MARK: - Tableview DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    
    
    //MARK: - Data Manipulation Methods
    func saveData(){
        do {
            print("Saving category data ...")
            try context.save()
        } catch  {
            print("Error saving message:  \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        do {
            categoryArray = try context.fetch(request)
            
        } catch {
            print("Error fetching categories from database:  \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK:  - Add New Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Todoey Category", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            
            self.saveData()
            
        }
        
        alert.addAction(alertAction)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New category"
            print(alertTextField.text!)
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //MARK:  - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = self.categoryArray[indexPath.row]
            
        }
    }
    
    
}
