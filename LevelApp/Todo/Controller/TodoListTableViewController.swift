//
//  TodoListTableViewController.swift
//  LevelApp
//
//  Created by 門屋　陽二郎 on 2018/06/29.
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit


// 星ボタンのセル選択のための機能拡張
public extension UITableView {
    
    func indexPathForView(_ view: UIView) -> IndexPath? {
        let origin = view.bounds.origin
        let viewOrigin = self.convert(origin, from: view)
        let indexPath = self.indexPathForRow(at: viewOrigin)
        return indexPath
    }
}




class TodoListTableViewController: UITableViewController {
    
    
    let todoCollection = TodoCollection.sharedInstance
    
    // 星ボタン完了のカウント初期値
    var count: Float = 0
    var countSkill1: Float = 0
    var countSkill2: Float = 0
    var countSkill3: Float = 0
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // セルの登録
        tableView.register(UINib(nibName: "TodoListTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoListTableViewCell")
        
        todoCollection.fetchTodos()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ヘッダーボタン作成
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        self.navigationController!.navigationBar.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新規作成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TodoListTableViewController.newTodo))
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    
    // セクション数
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    // セル数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.todoCollection.todos.count
    }
    
    
    

    // セルの内容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルの内容表示
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath)as! TodoListTableViewCell
        let todo = self.todoCollection.todos[indexPath.row]
        cell.labelCell.text = todo.title
        cell.detailCell.text = todo.descript
        cell.labelCell!.font = UIFont(name: "HirakakuProN-W3", size: 15)

        // 星ボタンを押した時
        cell.starButton2.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        if todo.finished == false {
            // 星ボタン(くり抜き)を表示
            cell.starButton2.setImage(UIImage(named: "icons8-スター-48.png"), for: .normal)
        } else {
            // 星ボタン(塗りつぶし)を表示
            cell.starButton2.setImage(UIImage(named: "icons8-星-48.png"), for: .normal)
            // 星ボタンを押した時、0.5を足す
            count += 0.5
            // 星ボタンの完了カウント数をuserDefaultsで保存
            let defaults = UserDefaults.standard
            defaults.set(count, forKey: "countStar")
            // 星ボタンの押したか押してないかを保存
            defaults.set(todo.finished, forKey: "finishedStar")
            
            // スキルの選別をしてlevelBarを増やす
            if cell.labelCell.text == defaults.object(forKey: "skill1Text") as? String {
                // 星ボタン(塗りつぶし)を表示
                cell.starButton2.setImage(UIImage(named: "icons8-星-48.png"), for: .normal)
                // 星ボタンを押した時、0.5を足す
                countSkill1 += 0.5
                // 星ボタンの完了カウント数をuserDefaultsで保存
                let defaults = UserDefaults.standard
                defaults.set(countSkill1, forKey: "countStar1")
                // 星ボタンの押したか押してないかを保存
                defaults.set(todo.finished, forKey: "finishedStar")
                
            } else if cell.labelCell.text == defaults.object(forKey: "skill2Text") as? String{
                // 星ボタン(塗りつぶし)を表示
                cell.starButton2.setImage(UIImage(named: "icons8-星-48.png"), for: .normal)
                // 星ボタンを押した時、0.5を足す
                countSkill2 += 0.5
                // 星ボタンの完了カウント数をuserDefaultsで保存
                let defaults = UserDefaults.standard
                defaults.set(countSkill2, forKey: "countStar2")
                // 星ボタンの押したか押してないかを保存
                defaults.set(todo.finished, forKey: "finishedStar")
                
            } else if cell.labelCell.text == defaults.object(forKey: "skill3Text") as? String {
                // 星ボタン(塗りつぶし)を表示
                cell.starButton2.setImage(UIImage(named: "icons8-星-48.png"), for: .normal)
                // 星ボタンを押した時、0.5を足す
                countSkill3 += 0.5
                // 星ボタンの完了カウント数をuserDefaultsで保存
                let defaults = UserDefaults.standard
                defaults.set(countSkill3, forKey: "countStar3")
                // 星ボタンの押したか押してないかを保存
                defaults.set(todo.finished, forKey: "finishedStar")
                
            }
        }
       
//      重要  let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "reuseIdentifier")
//        let todo = self.todoCollection.todos[indexPath.row]
//
//        cell.textLabel!.text = todo.title
//        cell.detailTextLabel!.text = todo.descript
//        cell.textLabel!.font = UIFont(name: "HirakakuProN-W3", size: 15)
        
        return cell
    }
    
    // 星ボタンを押した時の真偽
    var boolButton = false
    
    
    // 星ボタンを押した時の処理
    @objc func buttonTapped(_ button: UIButton) {
        if let indexPath = self.tableView.indexPathForView(button) {
            print("Button tapped at indexPath \(indexPath.row)")
            let todo = self.todoCollection.todos[indexPath.row + 1]
            todo.finished = true
            
        }
        else {
            print("Button indexPath not found")
            let todo = self.todoCollection.todos[0]
            todo.finished = true
        }
        self.tableView.reloadData()
    }
    
    
    @objc func newTodo() {
        self.performSegue(withIdentifier: "PresentNewTodoViewController", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.todoCollection.todos.remove(at: indexPath.row)
            self.todoCollection.save()
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.middle)
        default:
            return
        }
    }
    
    

}
