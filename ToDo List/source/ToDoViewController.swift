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
    var tableData: [[TodoListItem?]?]!
    
    
    //Navigation button ADD
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let newRowIndex = todoList.todos.count
        _ = todoList.newTodo()
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]

        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    //Navigation button DELETE
    @IBAction func deleteItems(_ sender: Any) {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            var items = [TodoListItem]()
            for indexPath in selectedRows {
                items.append(todoList.todos[indexPath.row])
            }
            todoList.remove(items: items)
            
            //For more animated removing
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        todoList = TodoList()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set large title for navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        //Turn on edit left bar button
        navigationItem.leftBarButtonItem = editButtonItem
        //Multiple selection turn on
        tableView.allowsMultipleSelectionDuringEditing = true
        
        let collation = UILocalizedIndexedCollation.current()
        let sectionTitleCount = collation.sectionTitles.count
        var allSections = [[TodoListItem?]?](repeating: nil, count: sectionTitleCount)
        var sectionNumber: Int = 0
        for item in todoList.todos {
            sectionNumber = collation.section(for: item, collationStringSelector: #selector(getter: TodoListItem.text))
            if allSections[sectionNumber] == nil {
                allSections[sectionNumber] = [TodoListItem?]()
            }
            allSections[sectionNumber]!.append(item)
        }
        tableData = allSections
    }
    
    //Set up edit navigation bar button
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(tableView.isEditing, animated: true)
    }

    //Return number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section] == nil ? 0 : tableData[section]!.count
    }
    
    func configureTextLabel(for cell: UITableViewCell, with item: TodoListItem) {
        if let textCell = cell as? TodoTableViewCell {
           textCell.todoTextLabel.text = item.text
        }
    }
    
    //Make correct value for .accesoryType
    func configureCheckmark(for cell: UITableViewCell, with item: TodoListItem) {
        guard let checkmarkCell = cell as? TodoTableViewCell else {
            return
        }
        
        //Change checkmark to opposite
        if item.checked {
            checkmarkCell.checkmarkLabel.text = "✔︎"
        } else {
            checkmarkCell.checkmarkLabel.text = ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath)
        //let item: TodoListItem = todoList.todos[indexPath.row]
        if let item = tableData[indexPath.section]?[indexPath.row] {
            //Configure text labels in cell
            configureTextLabel(for: cell, with: item)
            
            //Configure correct value of checkmark (.none by default)
            configureCheckmark(for: cell, with: item)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if tableView.isEditing {
                return
            }
            let item: TodoListItem = todoList.todos[indexPath.row]
            
            //Change .checked property to opposite
            item.toggleChecked()
            //Configure correct value of checkmark (opposite)
            configureCheckmark(for: cell, with: item)
            
            //Change appearance for row to opposite after selected
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //Setup for moving rows
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        todoList.move(item: todoList.todos[sourceIndexPath.row], at: destinationIndexPath.row)
        tableView.reloadData()
    }

    //Setup for swipe right->left
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
            if let itemDetailViewController = segue.destination as? ItemDetailViewController {
                itemDetailViewController.delegate = self
                itemDetailViewController.todoList = todoList
            }
        } else if segue.identifier == "EditItemSegue" {
            if let itemDetailViewController = segue.destination as? ItemDetailViewController {
                if let cell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: cell) {
                    let item = todoList.todos[indexPath.row]
                    
                    itemDetailViewController.delegate = self
                    itemDetailViewController.itemToEdit = item
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return UILocalizedIndexedCollation.current().sectionTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return UILocalizedIndexedCollation.current().section(forSectionIndexTitle: index)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return UILocalizedIndexedCollation.current().sectionTitles[section]
    }
}

extension TodoViewController: ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    //Add new todolistitem from addItemTabViewController (2nd screen)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: TodoListItem) {
        navigationController?.popViewController(animated: true)
        let newRowIndex = todoList.todos.count - 1
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]

        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    //Edit todolistitem from addItemTabViewController (2nd screen)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: TodoListItem) {
        navigationController?.popViewController(animated: true)
        if let index = todoList.todos.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureTextLabel(for: cell, with: item)
            }
        }
    }
}
