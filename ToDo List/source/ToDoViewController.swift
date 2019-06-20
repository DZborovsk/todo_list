//
//  ViewController.swift
//  ToDo List
//
//  Created by Danyil Zborovskyi on 6/12/19.
//  Copyright © 2019 BlueWolf Development. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    var todoList: TodoList
    
    //Navigator button ADD
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let newRowIndex = todoList.todos.count
        _ = todoList.newTodo()
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]

        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    required init?(coder aDecoder: NSCoder) {
        todoList = TodoList()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set large title for navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    //Return number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.todos.count
    }
    
    //Make correct value for .accesoryType
    func configureCheckmark(for cell: UITableViewCell, with item: TodoListItem) {
        guard let checkmark = cell.viewWithTag(1001) as? UILabel else {
            return
        }
        
        //Change .accesoryType to opposite
        if item.checked {
            checkmark.text = "✔︎"
        } else {
            checkmark.text = ""
        }
    
        //Change .checked object to opposite
        item.toggleChecked()
    }
    
    func configureTextLabel(for cell: UITableViewCell, with item: TodoListItem) {
        if let label = cell.viewWithTag(1000) as? UILabel {
            label.text = item.text
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath)
        let item: TodoListItem = todoList.todos[indexPath.row]
        
        //Configure text labels in cell
        configureTextLabel(for: cell, with: item)
        
        //Configure correct value of checkmark (.none by default)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item: TodoListItem = todoList.todos[indexPath.row]
            
            //Configure correct value of checkmark (opposite)
            configureCheckmark(for: cell, with: item)
            
            //Change appearance for row to opposite after selected
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    //Set for swipe right->left
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let indexPaths = [indexPath]

        //Remove todoitem from array
        todoList.todos.remove(at: indexPath.row)

        //Delete row in view
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    //Set for swipe left->right
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let complete = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.todoList.todos.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        complete.backgroundColor = .green
        let action = UISwipeActionsConfiguration(actions: [complete])
        return action
    }
    
    //Getting correct ViewController and set it up
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let addItemViewController = segue.destination as? AddItemTableViewController {
                addItemViewController.delegate = self
                addItemViewController.todoList = todoList
            }
        } else if segue.identifier == "EditItemSegue" {
            if let addItemViewController = segue.destination as? AddItemTableViewController {
                if let cell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: cell) {
                    let item = todoList.todos[indexPath.row]
                    
                    addItemViewController.itemToEdit = item
                    addItemViewController.delegate = self
                }
            }
        }
    }
}

extension TodoViewController: AddItemViewControllerDelegate {
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    //Add new todolistitem from addItemTabViewController (2nd screen)
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAdding item: TodoListItem) {
        let newRowIndex = todoList.todos.count
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        
        navigationController?.popViewController(animated: true)
        
        todoList.todos.append(item)
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    
}
