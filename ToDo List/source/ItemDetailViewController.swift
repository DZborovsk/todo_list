//
//  AdditemTableViewController.swift
//  ToDo List
//
//  Created by Danyil Zborovskyi on 6/17/19.
//  Copyright © 2019 BlueWolf Development. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: TodoListItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: TodoListItem)
}

class ItemDetailViewController: UITableViewController {
    weak var delegate: ItemDetailViewControllerDelegate?
    weak var todoList: TodoList?
    weak var itemToEdit: TodoListItem?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        if let editItem = itemToEdit, let text = textField.text {
            editItem.text = text
            delegate?.itemDetailViewController(self, didFinishEditing: editItem)
        } else {
            if let newItem = todoList?.newTodo(), let text = textField.text {
                newItem.text = text
                newItem.toggleChecked()
                delegate?.itemDetailViewController(self, didFinishAdding: newItem)
            }
        }
    }
    
    //Keyboard appear at display
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    //Cell unselectable
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension ItemDetailViewController: UITextFieldDelegate {
//    //Keyboard hide from display after press key: Done
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return false
//    }
    //DONE button unavailable while textField is empty
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }

        let newText: String = oldText.replacingCharacters(in: stringRange, with: string)

        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
        return true
    }
}
