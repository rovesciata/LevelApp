//
//  TodoCollection.swift
//  LevelApp
//
//  Created by 門屋　陽二郎 on 2018/06/29.
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit

class TodoCollection: NSObject {
    static let sharedInstance = TodoCollection()
    var todos:[Todo] = []
    
    
    
    func fetchTodos() {
        self.todos.removeAll()
        let defaults = UserDefaults.standard
        if let todoList = defaults.object(forKey: "todoLists") as? Array<Dictionary<String, AnyObject>> {
            for todoDic in todoList {
                let todo = TodoCollection.convertTodoModel(attiributes: todoDic)
//                self.todos.append(todo)
                self.todos.insert(todo, at: 0)
                
            }
        }
    }
    
    class func convertTodoModel(attiributes: Dictionary<String, AnyObject>) -> Todo {
        let todo = Todo()
        todo.title = attiributes["title"] as! String
        todo.descript = attiributes["descript"] as! String

        todo.finished = attiributes["finished"] as! Bool
        
        todo.date = attiributes["date"] as! String
        
        todo.id = attiributes["id"] as! String
        
        return todo
    }
    
    func addTodoCollection(todo: Todo) {
//        self.todos.append(todo)
        self.todos.insert(todo, at: 0)
        self.save()
    }
    
    func save (){
        var todoList: Array<Dictionary<String, AnyObject>> = []
        for todo in todos {
            let todoDic = TodoCollection.convertDictionary(todo: todo)
//            todoList.append(todoDic)
            todoList.insert(todoDic, at: 0)
        }
        let defaults = UserDefaults.standard
        defaults.set(todoList, forKey: "todoLists")
        defaults.synchronize()
        
    }
    
    class func convertDictionary(todo: Todo) -> Dictionary<String, AnyObject> {
        var dic = Dictionary<String, AnyObject>()
        dic["title"] = todo.title as AnyObject
        dic["descript"] = todo.descript as AnyObject
        dic["finished"] = todo.finished as AnyObject
        
        dic["date"] = todo.date as AnyObject
        
        dic["id"] = todo.id as AnyObject

        return dic
    }
    
}
