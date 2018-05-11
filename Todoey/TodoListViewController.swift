//
//  ViewController.swift
//  Todoey
//
//  Created by Joseph Anthony Castillon on 5/9/18.
//  Copyright © 2018 Joseph Anthony Castillon. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    let itemArray = ["Pay bills", "Buy groceries", "Go to library"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    //MARK: - Table Data Source Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Item selected:  " + itemArray[indexPath.row])
        
        let cellView = tableView.cellForRow(at: indexPath)!
        let text = cellView.textLabel!.text
        print("cell text:  " + text!)
        
        if cellView.accessoryType == .checkmark {
            cellView.accessoryType = .none
        } else {
            cellView.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}

