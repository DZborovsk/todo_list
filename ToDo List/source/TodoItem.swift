//
//  TodoListItem.swift
//  ToDo List
//
//  Created by Danyil Zborovskyi on 6/12/19.
//  Copyright © 2019 BlueWolf Development. All rights reserved.
//

import Foundation

class TodoListItem: NSObject {
    @objc var text: String = ""
    //Default value is FALSE because .accesoryType is `.none` by default
    var checked: Bool = false
    
    func toggleChecked() {
        checked = !checked
    }
}
