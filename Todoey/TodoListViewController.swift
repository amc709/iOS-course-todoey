//
//  ViewController.swift
//  Todoey
//
//  Created by Joseph Anthony Castillon on 5/9/18.
//  Copyright © 2018 Joseph Anthony Castillon. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    var itemArray = [Item]() // ["Pay bills", "Buy groceries", "Go to library"];
    
    // This refers to the UserDefaults storage
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Get updated itemArray from the UserDefaults plist
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
        
        var newItem = Item()
        newItem.item = "Do laundry"
        itemArray.append(newItem)
        
        newItem = Item()
        newItem.item = "Go to library"
        itemArray.append(newItem)
        
        newItem = Item()
        newItem.item = "Cook dinner"
        itemArray.append(newItem)
    }
    

    //MARK: - Table Data Source Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].item
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Item selected:  " + itemArray[indexPath.row])
        
        let cell = tableView.cellForRow(at: indexPath)!
//        let text = cell.textLabel!.text
//        print("cell text:  " + text!)
        
        let item = itemArray[indexPath.row]
        item.done = !item.done
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //MARK: - Add Todo ITems
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.item = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
        }
        
        alert.addAction(alertAction)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New todo item"
            print(alertTextField.text!)
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}

