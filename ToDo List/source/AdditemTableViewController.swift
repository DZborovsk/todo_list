//
//  AdditemTableViewController.swift
//  ToDo List
//
//  Created by Danyil Zborovskyi on 6/17/19.
//  Copyright © 2019 BlueWolf Development. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController)
    
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAdding item: TodoListItem)
}

class AddItemTableViewController: UITableViewController {
    weak var delegate: AddItemViewControllerDelegate?
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
        
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        if let textFieldText = textField.text {
            let newItem = TodoListItem()
            newItem.text = textFieldText
            
            delegate?.addItemViewController(self, didFinishAdding: newItem)
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

extension AddItemTableViewController: UITextFieldDelegate {
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
