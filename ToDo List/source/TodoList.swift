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
    
    //Creating new todo item
    func newTodo() -> TodoListItem {
        let newTodo = TodoListItem()
        
        //Set default value in new item for .checked true (.checkmark)
        newTodo.checked = true
        newTodo.text = randomTitle()
        todos.append(newTodo)
        return newTodo
    }
    
    //Moving todo item to particular index
    func move(item: TodoListItem, at index: Int) {
        guard let currentIndex = todos.firstIndex(of: item) else {
            return
        }
        todos.insert(item, at: index)
        todos.remove(at: currentIndex)
    }
    
    //Remove multiple items
    func remove(items: [TodoListItem]) {
        for item in items {
            if let index = items.firstIndex(of: item) {
                todos.remove(at: index)
            }
        }
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
