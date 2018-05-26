//
//  ViewController.swift
//  Todoey
//
//  Created by Joseph Anthony Castillon on 5/9/18.
//  Copyright © 2018 Joseph Anthony Castillon. All rights reserved.
//

import UIKit
import CoreData



class TodoListViewController: UITableViewController{

    
    var itemArray = [Item]() // ["Pay bills", "Buy groceries", "Go to library"];
    
    // This refers to the UserDefaults storage
//    let defaults = UserDefaults.standard
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory : Category? {
        didSet {
            
//            let request : NSFetchRequest<Item> = Item.fetchRequest()
//            let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//            request.predicate = predicate
//            loadData(with: request)

            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory
//            , in: .userDomainMask).first?.appendingPathComponent("TodoeyItems.plist")
//        print("Data file path:  \(dataFilePath)")
        
//        loadData()
    }
    

    //MARK: - Table Data Source Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
//        let cell = tableView.cellForRow(at: indexPath)!
//        item.done = !item.done
////
//        cell.accessoryType = item.done ? .checkmark : .none

        
        // To remove selected item
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //MARK: - Add Todo ITems
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in

            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            self.itemArray.append(newItem)

            self.saveData()
            
        }
        
        alert.addAction(alertAction)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New todo item"
            print(alertTextField.text!)
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:  - Data manipulation methods
    
    func saveData(){
        do {
            print("Saving data ...")
            try context.save()
        } catch  {
            print("Error saving message:  \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    // Declaring loadData method with a request parameter.  If the method
    // is called without that parameter, it will be provided by default
    func loadData(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil){
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)

        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate])
        }
        
        do {
            itemArray = try context.fetch(request)
            print("Items count:  \(itemArray.count)")
            print("Items:  \(itemArray)")
        } catch {
            print("Error fetching item from database:  \(error)")
        }
        tableView.reloadData()
    }

}






//MARK: - Search Bar Delegate Methods
extension TodoListViewController : UISearchBarDelegate{

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        // Predicate to the query
//        let predicate = NSPredicate(format: "title CONTAINS[cd]  %@", searchBar.text!)
//        request.predicate = predicate

//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//        request.sortDescriptors = [sortDescriptor]
        
        // The commented code above can be refactored with the following lines
        let predicate = NSPredicate(format: "title CONTAINS[cd]  %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadData(with: request, predicate: predicate)
        
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }

}
