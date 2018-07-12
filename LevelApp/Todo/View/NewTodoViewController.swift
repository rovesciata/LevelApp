//
//  NewTodoViewController.swift
//  LevelApp
//
//  Created by 門屋　陽二郎 on 2018/06/29.
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit

class NewTodoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var todoField: UITextField!
    @IBOutlet weak var skillSelectedLabel: UILabel!
    @IBOutlet weak var skillSegment: UISegmentedControl!
    
    // 星ボタンの生成
    @IBOutlet weak var starView: UIImageView!
    var checked: UIImage = UIImage(named: "icons8-星-48.png")!
    // 星ボタンの縮小
    var transScale = CGAffineTransform()
    
    
    let todoCollection = TodoCollection.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionView.layer.cornerRadius = 5
        descriptionView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        descriptionView.layer.borderWidth = 1
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewTodoViewController.tapGesture(_:)))
//        self.view.addGestureRecognizer(tapRecognizer)
        todoField.delegate = self
        
    }
    
    // 星ボタンを押した時の処理
    @IBAction func tapped(_ sender: UIButton) {
            starView.image = checked
        // 星ボタンの縮小処理
        transScale = CGAffineTransform(scaleX: 1, y: 1)
        starView.transform = transScale
    }
    

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
