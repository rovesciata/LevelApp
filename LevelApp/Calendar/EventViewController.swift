//
//  EventViewController.swift
//  LevelApp
//
//  Created by 門屋　陽二郎 on 2018/07/18.
//  Copyright © 2018年 cagioro. All rights reserved.
//


import UIKit
import RealmSwift


class EventViewController: UIViewController {
    var date: String!
    
//    let realm = try! Realm()
    
    //ディスプレイサイズ取得
    let w2 = UIScreen.main.bounds.size.width
    let h2 = UIScreen.main.bounds.size.height
    //スケジュール内容入力テキスト
    //let eventText = UITextView(frame: CGRect(x: (w2 - 300) / 2, y: 50, width: 300, height: 200))
    
    
    //日付フォーム(UIDatePickerを使用)
    let y = UIDatePicker(frame: CGRect(x: 0, y: 350, width: UIScreen.main.bounds.size.width, height: 100))
    //日付表示
    let y_text = UILabel(frame: CGRect(x: -20, y: 310, width: 300, height: 30))
    
    
    
    
    let todoCollection = TodoCollection.sharedInstance
    
    @IBOutlet weak var skillSelectedLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //キーボードの完了ボタン
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.commitButtonTapped))
        kbToolBar.items = [spacer, commitButton]
        descriptionView.inputAccessoryView = kbToolBar
        
        
        
        // 詳細記入欄
        descriptionView.layer.cornerRadius = 5
        descriptionView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        descriptionView.layer.borderWidth = 1
        
        
        
        //スケジュール内容入力テキスト設定
//        eventText.text = ""
//        eventText.layer.borderColor = UIColor.gray.cgColor
//        eventText.layer.borderWidth = 1.0
//        eventText.layer.cornerRadius = 10.0
//        view.addSubview(eventText)
        
        //日付フォーム設定
        y.datePickerMode = UIDatePickerMode.date
        y.timeZone = NSTimeZone.local
        y.addTarget(self, action: #selector(picker(_:)), for: .valueChanged)
        view.addSubview(y)
        
        //日付表示設定
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        y_text.text = formatter.string(from: y.date)
        
        y_text.backgroundColor = .white
        y_text.textAlignment = .center
        view.addSubview(y_text)
        
        //「書く!」ボタン
        let eventInsert = UIButton(frame: CGRect(x: 290, y: 35, width: 70, height: 25))
        eventInsert.setTitle("保存", for: UIControlState())
        eventInsert.setTitleColor(.black, for: UIControlState())
        eventInsert.backgroundColor = .white
        eventInsert.layer.cornerRadius = 5.0
        eventInsert.layer.borderColor = UIColor.black.cgColor
        eventInsert.layer.borderWidth = 1.0
        eventInsert.addTarget(self, action: #selector(saveEvent(_:)), for: .touchUpInside)
        view.addSubview(eventInsert)
        
        //「戻る!」ボタン
        let backBtn = UIButton(frame: CGRect(x: 10, y: 35, width: 50, height: 25))
//        let backBtn = UIButton(frame: CGRect(x: (w - 200) / 2, y: h - 60, width: 150, height: 30))
        backBtn.setTitle("×", for: UIControlState())
        backBtn.setTitleColor(.black, for: UIControlState())
        backBtn.backgroundColor = .white
        backBtn.layer.cornerRadius = 5.0
        backBtn.layer.borderColor = UIColor.black.cgColor
        backBtn.layer.borderWidth = 1.0
        backBtn.addTarget(self, action: #selector(onbackClick(_:)), for: .touchUpInside)
        view.addSubview(backBtn)
        
    }
    
        @objc func saveEvent(_ : UIButton){
            
            let todo = Todo()
            
            // 　defaults.userの値をタスク画面に表示
            todo.title = UserDefaults.standard.object(forKey: "text1") as! String
            //            todo.title = todoField.text!
            todo.descript = descriptionView.text
            // enumのTodoSkill型に変換されたものを代入
            //            todo.skill = TodoSkill(rawValue: skillSegment.selectedSegmentIndex)!
            todo.finished = false
            
            todo.date = self.y_text.text!
            
            todo.id = String("\(arc4random())")
            
            //        let defaults = UserDefaults.standard
            //        defaults.set(todo.date, forKey: "dateCalendar")
            
            self.todoCollection.addTodoCollection(todo: todo)
            print(self.todoCollection.todos)
    
    
            //前のページに戻る
            dismiss(animated: true, completion: nil)
    
        }

    //画面遷移(カレンダーページ)
    @objc func onbackClick(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //日付フォーム
    @objc func picker(_ sender:UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        y_text.text = formatter.string(from: sender.date)
        view.addSubview(y_text)
    }
    
    //DB書き込み処理
//    @objc func saveEvent(_ : UIButton){
//        print("データ書き込み開始")
//
//        let realm = try! Realm()
//
//        try! realm.write {
//            //日付表示の内容とスケジュール入力の内容が書き込まれる。
//            let Events = [Event(value: ["date": y_text.text, "event": eventText.text])]
//            realm.add(Events)
//            print("データ書き込み中")
//        }
//
//        print("データ書き込み完了")
//
//        //前のページに戻る
//        dismiss(animated: true, completion: nil)
//
//    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
//        self.navigationController!.navigationBar.tintColor = UIColor.black
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "キャンセル", style: UIBarButtonItemStyle.plain, target: self, action: #selector(EventViewController.close))
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.plain, target: self, action: #selector(EventViewController.save))
        skillSelectedLabel.text =  UserDefaults.standard.object(forKey: "text1") as? String
        
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
//    @objc func save() {
//        //        if todoField.text!.isEmpty {
//        //            let alertView = UIAlertController(title: "エラー", message: "タスクが記述されていません", preferredStyle: UIAlertControllerStyle.alert)
//        //            alertView.addAction(UIAlertAction(title: "はい", style: UIAlertActionStyle.default, handler: nil))
//        //            self.present(alertView, animated: true, completion: nil)
//        //        } else {
//        let todo = Todo()
//
//        // 　defaults.userの値をタスク画面に表示
//        todo.title = UserDefaults.standard.object(forKey: "text1") as! String
//        //            todo.title = todoField.text!
//        todo.descript = descriptionView.text
//        // enumのTodoSkill型に変換されたものを代入
//        //            todo.skill = TodoSkill(rawValue: skillSegment.selectedSegmentIndex)!
//        todo.finished = false
//
//        todo.date = self.y_text.text!
//
//        todo.id = String("\(arc4random())")
//
////        let defaults = UserDefaults.standard
////        defaults.set(todo.date, forKey: "dateCalendar")
//
//        self.todoCollection.addTodoCollection(todo: todo)
//        print(self.todoCollection.todos)
//
//
//
//
////                try! realm.write {
////                    //日付表示の内容とスケジュール入力の内容が書き込まれる。
////                    let Events = [Event(value: ["date": y_text.text])]
////                    realm.add(Events)
////                    print("データ書き込み中")
//
//
//
//
//
//        self.dismiss(animated: true, completion: nil)
//
//
//    }
    
    
    
    
    
    
    // キーボードの完了ボタン処理
    @objc func commitButtonTapped() {
        self.view.endEditing(true)
    }
    
}
