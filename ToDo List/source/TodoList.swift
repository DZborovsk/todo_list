//
//  TodoList.swift
//  ToDo List
//
//  Created by Danyil Zborovskyi on 6/13/19.
//  Copyright © 2019 BlueWolf Development. All rights reserved.
//

import Foundation

class TodoList {
    var todos: [TodoListItem] = []
    
    init() {
        let row0Item = TodoListItem()
        let row1Item = TodoListItem()
        let row2Item = TodoListItem()
        let row3Item = TodoListItem()
        let row4Item = TodoListItem()

        row0Item.text = randomTitle()
        row1Item.text = randomTitle()
        row2Item.text = randomTitle()
        row3Item.text = randomTitle()
        row4Item.text = randomTitle()
        
        todos.append(row0Item)
        todos.append(row1Item)
        todos.append(row2Item)
        todos.append(row3Item)
        todos.append(row4Item)
    }
    
    func newTodo() -> TodoListItem {
        let newTodo = TodoListItem()
        
        //Set default value in new item for .checked true (.checkmark)
        newTodo.checked = true
        newTodo.text = randomTitle()
        todos.append(newTodo)
        return newTodo
    }
    
    //Generate random text title
    private func randomTitle() -> String {
        let titles: [String] = [
            "New todo item",
            "Generic todo",
            "Fill me out",
            "I need something to do",
            "Much to do about nothing"
        ]
        let randomNumber: Int = Int.random(in: 0 ... titles.count - 1)
        
        return titles[randomNumber]
    }
}
