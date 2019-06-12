//
//  ViewController.swift
//  ToDo List
//
//  Created by Danyil Zborovskyi on 6/12/19.
//  Copyright © 2019 BlueWolf Development. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath)
        return cell
    }

}

