//
//  NewTodoViewController.swift
//  LevelApp
//
//  Created by 門屋　陽二郎 on 2018/06/29.
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit
import RealmSwift

// スケジュール登録のディスプレイサイズ取得
//let w2 = UIScreen.main.bounds.size.width
//let h2 = UIScreen.main.bounds.size.height
//// スケジュール内容入力テキスト
////let eventText = UITextView(frame: CGRect(x: (w2 - 300) / 2, y: 100, width: 300, height: 200))
//// 日付フォーム(UIDatePickerを使用)
//let y = UIDatePicker(frame: CGRect(x: 0, y: 300, width: w2, height: 300))
//// 日付表示
//let y_text = UILabel(frame: CGRect(x: (w2 - 300) / 2, y: 570, width: 300, height: 20))


    


class NewTodoViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var todoField: UITextField!
    @IBOutlet weak var skillSelectedLabel: UILabel!
    @IBOutlet weak var skillSegment: UISegmentedControl!
    
    // 星ボタンの生成
//    @IBOutlet weak var starView: UIImageView!
//    var checked: UIImage = UIImage(named: "icons8-星-48.png")!
//    // 星ボタンの縮小
//    var transScale = CGAffineTransform()
    
    
    let todoCollection = TodoCollection.sharedInstance
    
    
    // カレンダーのスケジュール登録日付定義
    var date: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // スケジュール内容入力テキスト設定
//        eventText.text = ""
//        eventText.layer.borderColor = UIColor.gray.cgColor
//        eventText.layer.borderWidth = 1.0
//        eventText.layer.cornerRadius = 10.0
//        view.addSubview(eventText)
        // 日付フォーム設定
//        y.datePickerMode = UIDatePickerMode.date
//        y.timeZone = NSTimeZone.local
//        y.addTarget(self, action: #selector(picker(_:)), for: .valueChanged)
//        view.addSubview(y)
//        // 日付表示設定
//        y_text.backgroundColor = .white
//        y_text.textAlignment = .center
//        view.addSubview(y_text)
        
        //日付フォーム
//        func picker(_ sender:UIDatePicker){
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy/MM/dd"
//            y_text.text = formatter.string(from: sender.date)
//            view.addSubview(y_text)
//        }
//        // DB書き込み処理
//        func saveEvent(_ : UIButton) {
//            print("データ書き込み開始")
//
//            let realm = try! Realm()
//
//            try! realm.write {
//                // 日付表示の内容とスケジュール入力の内容が書き込まれる。
//                let Events = [Event(value: ["date": y_text.text, "event": eventText.text])]
//                realm.add(Events)
//                print("データ書き込み中")
//            }
//
//            print("データ書き込み完了")
//            // 前のページに戻る
//            dismiss(animated: true, completion: nil)
//        }
        
        // 詳細記入欄
        descriptionView.layer.cornerRadius = 5
        descriptionView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        descriptionView.layer.borderWidth = 1
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewTodoViewController.tapGesture(_:)))
//        self.view.addGestureRecognizer(tapRecognizer)
        todoField.delegate = self
        
    }
    
    // 星ボタンを押した時の処理
//    @IBAction func tapped(_ sender: UIButton) {
//            starView.image = checked
//        // 星ボタンの縮小処理
//        transScale = CGAffineTransform(scaleX: 1, y: 1)
//        starView.transform = transScale
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        self.navigationController!.navigationBar.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NewTodoViewController.close))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NewTodoViewController.save))
        skillSelectedLabel.text =  UserDefaults.standard.object(forKey: "text1") as? String
        
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
//        if todoField.text!.isEmpty {
//            let alertView = UIAlertController(title: "エラー", message: "タスクが記述されていません", preferredStyle: UIAlertControllerStyle.alert)
//            alertView.addAction(UIAlertAction(title: "はい", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alertView, animated: true, completion: nil)
//        } else {
            let todo = Todo()
        
        // 　defaults.userの値をタスク画面に表示
            todo.title = UserDefaults.standard.object(forKey: "text1") as! String
//            todo.title = todoField.text!
            todo.descript = descriptionView.text
            // enumのTodoSkill型に変換されたものを代入
//            todo.skill = TodoSkill(rawValue: skillSegment.selectedSegmentIndex)!
        todo.finished = false
            self.todoCollection.addTodoCollection(todo: todo)
            print(self.todoCollection.todos)
            self.dismiss(animated: true, completion: nil)
//    }
        
        

        
    }
    
    
    
    
//    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
//        todoField.resignFirstResponder()
//        descriptionView.resignFirstResponder()
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        todoField.resignFirstResponder()
//        return true
//    }

    // skillSelectionから戻る
//    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
//
//        // userDefaultsの読み込み
////        let defaults = UserDefaults.standard
////        skillSelectedLabel.text = defaults.object(forKey: "skill1Text") as? String
////        skillSelectedLabel.text = defaults.object(forKey: "skill2Text") as? String
////        skillSelectedLabel.text = defaults.object(forKey: "skill3Text") as? String
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
