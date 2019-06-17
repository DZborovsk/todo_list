//
//  AdditemTableViewController.swift
//  ToDo List
//
//  Created by Danyil Zborovskyi on 6/17/19.
//  Copyright © 2019 BlueWolf Development. All rights reserved.
//

import UIKit

class AdditemTableViewController: UITableViewController {
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        print(textField.text!)
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

extension AdditemTableViewController: UITextFieldDelegate {
    //Keyboard hide from display after press key: Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
