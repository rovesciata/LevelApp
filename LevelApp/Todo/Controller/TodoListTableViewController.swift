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
//        let origin = view.bounds.origin
        // セルの位置を取得
        let height: CGPoint = CGPoint(x: 0, y: 0)
        let viewOrigin = self.convert(height, from: view)
        let indexPath = self.indexPathForRow(at: viewOrigin)
        return indexPath
    }
}

class TodoListTableViewController: UITableViewController {
    
    
    let todoCollection = TodoCollection.sharedInstance
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // セルの登録
        tableView.register(UINib(nibName: "TodoListTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoListTableViewCell")
        
        todoCollection.fetchTodos()
        
        
        //セルの高さを自動で計算
        self.tableView.estimatedRowHeight = 78
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
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
        cell.labelCell!.font = UIFont(name: "HirakakuProN-W6", size: 15)
        
        
        
        

        // 星ボタンを押した時
        cell.starButton2.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        
        let defaults = UserDefaults.standard
        

//        todo.finished = defaults.bool(forKey: "finishedStar")
        let redUpAble = defaults.bool(forKey: "redUpBool")
        cell.starButton2.isEnabled = true
        
        
        if todo.finished == false {
            // 星ボタン(くり抜き)を表示
            if cell.labelCell.text == defaults.object(forKey: "skill1Text") as? String {
                cell.starButton2.setImage(UIImage(named: "赤星無し.png"), for: .normal)
            }
            else if cell.labelCell.text == defaults.object(forKey: "skill2Text") as? String {
                    cell.starButton2.setImage(UIImage(named: "黄星無し.png"), for: .normal)
            } else if cell.labelCell.text == defaults.object(forKey: "skill3Text") as? String {
                cell.starButton2.setImage(UIImage(named: "青星無し.png"), for: .normal)
                
            }
        
            
        } else {
            // 星ボタン(塗りつぶし)を表示
            let defaults = UserDefaults.standard
            if cell.labelCell?.text == defaults.object(forKey: "skill1Text") as? String {
                cell.starButton2.setImage(UIImage(named: "赤星有り.png"), for: .normal)
                cell.starView.isHidden = false
                cell.starView.image = UIImage(named: "赤星有り.png")
       
            } else if cell.labelCell?.text == defaults.object(forKey: "skill2Text") as? String {
                cell.starButton2.setImage(UIImage(named: "黄星有り.png"), for: .normal)
                cell.starView.isHidden = false
                cell.starView.image = UIImage(named: "黄星有り.png")
                
            } else if cell.labelCell?.text == defaults.object(forKey: "skill3Text") as? String {
                cell.starButton2.setImage(UIImage(named: "青星有り.png"), for: .normal)
                cell.starView.isHidden = false
                cell.starView.image = UIImage(named: "青星有り.png")
            }
            
            cell.starButton2.isEnabled = false
            
        }
        // 星ボタンの押したか押してないかを保存
        defaults.set(todo.finished, forKey: "finishedStar")
        
//      重要  let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "reuseIdentifier")
//        let todo = self.todoCollection.todos[indexPath.row]
//
//        cell.textLabel!.text = todo.title
//        cell.detailTextLabel!.text = todo.descript
//        cell.textLabel!.font = UIFont(name: "HirakakuProN-W3", size: 15)
        
        return cell
    }
    
    // 星ボタンが押された回数の定義
    var times = 0
    var timesYellow = 0
    var timesBlue = 0
    
    var timesSkill1 = 0
    var timesSkill2 = 0
    var timesSkill3 = 0
    
    
    // 星ボタンを押した時の処理
    @objc func buttonTapped(_ button: UIButton) {
        
            if let indexPath = self.tableView.indexPathForView(button) {
                print("Button tapped at indexPath \(indexPath.row)")
                let todo = self.todoCollection.todos[indexPath.row]
                todo.finished = true
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath)as! TodoListTableViewCell
                
                cell.labelCell.text = todo.title
                
                
                let defaults = UserDefaults.standard
                
                // 星ボタンの押したか押してないかを保存
//                defaults.set(todo.finished, forKey: "finishedStar")
                
                
                
                
                // スキルの選別をしてlevelBarを増やす
                // skill1の場合
                if cell.labelCell.text == defaults.object(forKey: "skill1Text") as? String {
                    
//                    cell.starButton2.setImage(UIImage(named: "赤星有り.png"), for: .normal)
                    
                    
                    times = defaults.integer(forKey: "numberTimes")
                    
                    times += 1
                    
                    var count0to10: Float = 0.0
                    
                    var count10to30: Float = 0.0
                    
                    var count30to50: Float = 0.0
                    
                    var count50to70: Float = 0.0
                    
                    var count70to99: Float = 0.0
                    
                    
                    // 星ボタンを押した時、0.45を足す
                    count0to10 += 0.45
                    
                    count10to30 += 0.100
                    
                    count30to50 += 0.050
                    
                    count50to70 += 0.010
                    
                    count70to99 += 0.0036
                    
                    
                    // 星ボタンの完了カウント数をuserDefaultsで保存
                    
                    defaults.set(count0to10, forKey: "countStar")
                    defaults.set(count10to30, forKey: "countStar10to30")
                    defaults.set(count30to50, forKey: "countStar30to50")
                    defaults.set(count50to70, forKey: "countStar50to70")
                    defaults.set(count70to99, forKey: "countStar70to99")
                    
                    defaults.set(times, forKey: "numberTimes")
                    
                    
                    var countSkill10to10: Float = 0.0
                    var countSkill110to30: Float = 0.0
                    var countSkill130to50: Float = 0.0
                    var countSkill150to70: Float = 0.0
                    var countSkill170to99: Float = 0.0
                    
                    timesSkill1 = defaults.integer(forKey: "numberTimes1")
                    timesSkill1 += 1
                    
                    // 星ボタンを押した時、0.45を足す
                    countSkill10to10 += 0.45
                    
                    countSkill110to30 += 0.100
                    
                    countSkill130to50 += 0.050
                    
                    countSkill150to70 += 0.010
                    
                    countSkill170to99 += 0.0036
                        
                    // Skill1の星ボタンの完了カウント数を保存
                    defaults.set(countSkill10to10, forKey: "countStar1")
                    defaults.set(countSkill110to30, forKey: "countStar110to30")
                    defaults.set(countSkill130to50, forKey: "countStar130to50")
                    defaults.set(countSkill150to70, forKey: "countStar150to70")
                    defaults.set(countSkill170to99, forKey: "countStar170to99")
                    
                    defaults.set(timesSkill1, forKey: "numberTimes1")
                    
                    
                    // 星ボタンの押したか押してないかを保存
//                    defaults.set(todo.finished, forKey: "finishedStar")
                    
                    // Skill2の星ボタンをタップした場合
                } else if cell.labelCell.text == defaults.object(forKey: "skill2Text") as? String{
                    
//                    cell.starButton2.setImage(UIImage(named: "黄星有り.png"), for: .normal)
                    
                    timesYellow = defaults.integer(forKey: "numberTimesYellow")
                    
                    timesYellow += 1
                    
                    var count0to10: Float = 0.0
                    
                    var count10to30: Float = 0.0
                    
                    var count30to50: Float = 0.0
                    
                    var count50to70: Float = 0.0
                    
                    var count70to99: Float = 0.0
                    
                    
                    // 星ボタンを押した時、0.45を足す
                    count0to10 += 0.45
                    
                    count10to30 += 0.100
                    
                    count30to50 += 0.050
                    
                    count50to70 += 0.010
                    
                    count70to99 += 0.0036
                    
                    
                    // 星ボタンの完了カウント数をuserDefaultsで保存
                    
                    defaults.set(count0to10, forKey: "countStar")
                    defaults.set(count10to30, forKey: "countStar10to30")
                    defaults.set(count30to50, forKey: "countStar30to50")
                    defaults.set(count50to70, forKey: "countStar50to70")
                    defaults.set(count70to99, forKey: "countStar70to99")
                    
                    defaults.set(timesYellow, forKey: "numberTimesYellow")
                    
                    var countSkill20to10: Float = 0.0
                    var countSkill210to30: Float = 0.0
                    var countSkill230to50: Float = 0.0
                    var countSkill250to70: Float = 0.0
                    var countSkill270to99: Float = 0.0
                    
                    timesSkill2 = defaults.integer(forKey: "numberTimes2")
                    timesSkill2 += 1
                    
                    // 星ボタンを押した時、0.45を足す
                    countSkill20to10 += 0.45
                    
                    countSkill210to30 += 0.100
                    
                    countSkill230to50 += 0.050
                    
                    countSkill250to70 += 0.010
                    
                    countSkill270to99 += 0.0036
                    
                    // Skill2の星ボタンの完了カウント数を保存
                    defaults.set(countSkill20to10, forKey: "countStar2")
                    defaults.set(countSkill210to30, forKey: "countStar210to30")
                    defaults.set(countSkill230to50, forKey: "countStar230to50")
                    defaults.set(countSkill250to70, forKey: "countStar250to70")
                    defaults.set(countSkill270to99, forKey: "countStar270to99")
                    
                    defaults.set(timesSkill2, forKey: "numberTimes2")
                    
                    
                    // 星ボタンの押したか押してないかを保存
//                    defaults.set(todo.finished, forKey: "finishedStar")
                    
                    // Skill3の星ボタンを押した場合
                } else if cell.labelCell.text == defaults.object(forKey: "skill3Text") as? String {
                    
//                    cell.starButton2.setImage(UIImage(named: "青星有り.png"), for: .normal)
                    
                    
                    timesBlue = defaults.integer(forKey: "numberTimesBlue")
                    
                    timesBlue += 1
                    
                    var count0to10: Float = 0.0
                    
                    var count10to30: Float = 0.0
                    
                    var count30to50: Float = 0.0
                    
                    var count50to70: Float = 0.0
                    
                    var count70to99: Float = 0.0
                    
                    
                    // 星ボタンを押した時、0.45を足す
                    count0to10 += 0.45
                    
                    count10to30 += 0.100
                    
                    count30to50 += 0.050
                    
                    count50to70 += 0.010
                    
                    count70to99 += 0.0036
                    
                    
                    // 星ボタンの完了カウント数をuserDefaultsで保存
                    
                    defaults.set(count0to10, forKey: "countStar")
                    defaults.set(count10to30, forKey: "countStar10to30")
                    defaults.set(count30to50, forKey: "countStar30to50")
                    defaults.set(count50to70, forKey: "countStar50to70")
                    defaults.set(count70to99, forKey: "countStar70to99")
                    
                    defaults.set(timesBlue, forKey: "numberTimesBlue")
                    
                    var countSkill30to10: Float = 0.0
                    var countSkill310to30: Float = 0.0
                    var countSkill330to50: Float = 0.0
                    var countSkill350to70: Float = 0.0
                    var countSkill370to99: Float = 0.0
                    
                    timesSkill3 = defaults.integer(forKey: "numberTimes3")
                    timesSkill3 += 1
                    
                    // 星ボタンを押した時、0.45を足す
                    countSkill30to10 += 0.45
                    
                    countSkill310to30 += 0.100
                    
                    countSkill330to50 += 0.050
                    
                    countSkill350to70 += 0.010
                    
                    countSkill370to99 += 0.0036
                    
                    // Skill3の星ボタンの完了カウント数を保存
                    defaults.set(countSkill30to10, forKey: "countStar3")
                    defaults.set(countSkill310to30, forKey: "countStar310to30")
                    defaults.set(countSkill330to50, forKey: "countStar330to50")
                    defaults.set(countSkill350to70, forKey: "countStar350to70")
                    defaults.set(countSkill370to99, forKey: "countStar370to99")
                    
                    defaults.set(timesSkill3, forKey: "numberTimes3")
                    
//                    // 星ボタンの押したか押してないかを保存
//                    defaults.set(todo.finished, forKey: "finishedStar")
                    
                }
                // 星ボタンの押したか押してないかを保存
                defaults.set(todo.finished, forKey: "finishedStar")
            
        }
        
        // 配列を全て保存
        self.todoCollection.save()
        
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
