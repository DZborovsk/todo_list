//
//  ViewController.swift
//  ToDo List
//
//  Created by Danyil Zborovskyi on 6/12/19.
//  Copyright © 2019 BlueWolf Development. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    var row0Item: ToDoListItem
    
    required init?(coder aDecoder: NSCoder) {
        row0Item = ToDoListItem()
        row0Item.text = "Hello world 0 row"
        super.init(coder: aDecoder)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //Return number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
        if indexPath.row == 0 {
            //Change .accesoryType to opposite
            if row0Item.checked {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            //Change .checked to opposite
            row0Item.checked = !row0Item.checked
        } else {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath)
        
        //Configure text labels in cell
        if let label = cell.viewWithTag(1000) as? UILabel {
            if indexPath.row == 0 {
                label.text = row0Item.text
            } else if indexPath.row % 5 == 1 {
                label.text = "Watch a movie"
            } else if indexPath.row % 5 == 2 {
                label.text = "Code an app"
            } else if indexPath.row % 5 == 3 {
                label.text = "Walk the dog"
            } else if indexPath.row % 5 == 4 {
                label.text = "Study design patterns"
            }
        }
        
        //Configure correct value of checkmark (.none by default)
        configureCheckmark(for: cell, at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            //Configure correct value of checkmark (opposite)
            configureCheckmark(for: cell, at: indexPath)
            
            //Change appearance for row to opposite after selected
            tableView.deselectRow(at: indexPath, animated: true)
        }
    
    }

}
