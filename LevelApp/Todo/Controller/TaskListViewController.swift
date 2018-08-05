//
//  TaskListViewController.swift
//  LevelApp
//
//  Created by 門屋　陽二郎 on 2018/08/03.
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit
import AVFoundation

// 星ボタンのセル選択のための機能拡張
public extension UITableView {
    
    func indexPathForViewTodo(_ view: UIView) -> IndexPath? {
        //        let origin = view.bounds.origin
        // セルの位置を取得
        let height: CGPoint = CGPoint(x: 0, y: 0)
        let viewOrigin = self.convert(height, from: view)
        let indexPath = self.indexPathForRow(at: viewOrigin)
        return indexPath
    }
}

class TaskListViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    var audioPlayerClear : AVAudioPlayer! = nil //クリア時用
    var audioPlayerClearY : AVAudioPlayer! = nil //クリア時用
    var audioPlayerClearB: AVAudioPlayer! = nil //クリア時用

    let todoCollection = TodoCollection.sharedInstance
    
    //テーブルビューインスタンス
    private var tableView: UITableView!
    
    //SearchBarインスタンス
    private var mySearchBar: UISearchBar!
    
    
    //テーブルビューに表示する配列
    private var myItems: [String] = []
    
    var todoTitleArray: [String] = []
    
    
    var searchTodoCollection: [Todo] = []
    
    //検索結果が入る配列
    //    private var searchTodoCollection: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        //Viewの大きさを取得
        let viewWidth = self.view.frame.size.width
        let viewHeight = self.view.frame.size.height
        
        // MARK: - NavigationBar関連
        //UINavigationBarを作成
        let myNavBar = UINavigationBar()
        //大きさの指定
        myNavBar.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: viewWidth, height: 44)
        
        //タイトル、虫眼鏡ボタンの作成
        let myNavItems = UINavigationItem()
        myNavItems.title = "タスク一覧"
        let rightNavBtn =  UIBarButtonItem(barButtonSystemItem:  .search, target: self, action: #selector(rightBarBtnClicked(sender:)))
        myNavItems.leftBarButtonItem = rightNavBtn
        rightNavBtn.action = #selector(rightBarBtnClicked(sender:))
        myNavItems.rightBarButtonItem = rightNavBtn;
        myNavBar.pushItem(myNavItems, animated: true)
        //ナビゲーションバーをviewに追加
        self.view.addSubview(myNavBar)
        
        
        // MARK: - SearchBar関連
        //SearchBarの作成
        mySearchBar = UISearchBar()
        //デリゲートを設定
        mySearchBar.delegate = self
        //大きさの指定
        mySearchBar.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: viewWidth, height: 44)
        
        //キャンセルボタンの追加
        mySearchBar.showsCancelButton = true
        
        
        
        // MARK: - TableView関連
        //テーブルビューの初期化
        tableView = UITableView()
        //デリゲートの設定
        tableView.delegate = self
        tableView.dataSource = self
        //テーブルビューの大きさの指定
        tableView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + myNavBar.frame.height, width: viewWidth, height: viewHeight - UIApplication.shared.statusBarFrame.height-myNavBar.frame.height)
        //先ほど作成したSearchBarを作成
        tableView.tableHeaderView = mySearchBar
        //サーチバーの高さだけ初期位置を下げる
        tableView.contentOffset = CGPoint(x: 0,y :44)
        
        //テーブルビューの設置
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        
        // セルの登録
        tableView.register(UINib(nibName: "TodoListTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoListTableViewCell")
        
        todoCollection.fetchTodos()
        
        for todo in todoCollection.todos {
            todoTitleArray.append(todo.title)
        }


        myItems = todoTitleArray
        searchTodoCollection = todoCollection.todos
        
        //セルの高さを自動で計算
        self.tableView.estimatedRowHeight = 78
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        makeSound()
        makeSoundY()
        makeSoundB()
        
    }
    
    // ヘッダーボタン作成
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        //        self.navigationController!.navigationBar.tintColor = UIColor.black
        //        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新規作成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TodoListTableViewController.newTodo))
        //        self.navigationItem.leftBarButtonItem = editButtonItem
        
        searchTodoCollection = todoCollection.todos
        
        self.tableView.reloadData()
        
    }
    
    
    //MARK: - ナビゲーションバーの右の虫眼鏡が押されたら呼ばれる
    @objc internal func rightBarBtnClicked(sender: UIButton){
        print("rightBarBtnClicked")
        
        tableView.contentOffset = CGPoint(x: 0,y : 0)
    }
    
    //MARK: - 渡された文字列を含む要素を検索し、テーブルビューを再表示する
    func searchItems(searchText: String){
        searchTodoCollection = []
        //要素を検索する
        if searchText != "" {
            todoTitleArray = myItems.filter { myItem in
                return (myItem).contains(searchText)
            }
            for todo in todoCollection.todos {
                if searchText == todo.title {
                    searchTodoCollection.append(todo)
                }
            }
            
        } else{
            //渡された文字列が空の場合は全てを表示
            searchTodoCollection = todoCollection.todos
        }
        
        //tableViewを再読み込みする
        tableView.reloadData()
    }
    
    // MARK: - SearchBarのデリゲードメソッドたち
    //MARK: テキストが変更される毎に呼ばれる
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //検索する
        searchItems(searchText: searchText)
    }
    
    //MARK: キャンセルボタンが押されると呼ばれる
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        mySearchBar.text = ""
        self.view.endEditing(true)
        searchTodoCollection = todoCollection.todos
        
        //tableViewを再読み込みする
        tableView.reloadData()
    }
    
    //MARK: Searchボタンが押されると呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
        //検索する
        searchItems(searchText: mySearchBar.text! as String)
    }
    
    
    
    // MARK: - Table view data source
    
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }
    
    //セクションのタイトル
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
//    
//    
//            return UserDefaults.standard.object(forKey: "dateSection") as? String
//    
//    
//        }
    
    // セル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //テーブルビューのセルの数はmyItems配列の数とした
        return self.searchTodoCollection.count
        
        //        return self.todoCollection.todos.count
    }
    
    // セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルの内容表示
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath)as! TodoListTableViewCell
        let todo = self.searchTodoCollection[indexPath.row]
        //        let todo = self.todoCollection.todos[indexPath.row]
        cell.labelCell.text = todo.title
        cell.detailCell.text = todo.descript
        cell.labelCell!.font = UIFont(name: "HirakakuProN-W6", size: 15)
        
        
        
        
        
        
        
        //        cell.labelCell.text = self.searchResult[indexPath.row] as? String
        
        
        
        
        
        // 星ボタンを押した時
        cell.starButton2.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        
        let defaults = UserDefaults.standard
        
        cell.starButton2.isEnabled = true
        
        
        cell.redStarImage.isHidden = true
        
        
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
                // 星ボタンを押された後、無効化して塗りつぶし星を表示
                for todo in todoCollection.todos {
                    if todo.finished == true {
                        cell.starButton2.isEnabled = false
                        cell.redStarImage.isHidden = false
                        cell.redStarImage.image = UIImage(named: "赤星有り.png")
                        cell.starButton2.addSubview(cell.redStarImage)
                    }
                }
            } else if cell.labelCell?.text == defaults.object(forKey: "skill2Text") as? String {
                for todo in todoCollection.todos {
                    if todo.finished == true {
                        cell.starButton2.isEnabled = false
                        cell.redStarImage.isHidden = false
                        cell.redStarImage.image = UIImage(named: "黄星有り.png")
                        cell.starButton2.addSubview(cell.redStarImage)
                    }
                }
            } else if cell.labelCell?.text == defaults.object(forKey: "skill3Text") as? String {
                for todo in todoCollection.todos {
                    if todo.finished == true {
                        cell.starButton2.isEnabled = false
                        cell.redStarImage.isHidden = false
                        cell.redStarImage.image = UIImage(named: "青星有り.png")
                        cell.starButton2.addSubview(cell.redStarImage)
                        
                    }
                }
            }
            
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
        
        if let indexPath = self.tableView.indexPathForViewTodo(button) {
            print("Button tapped at indexPath \(indexPath.row)")
            let todo = self.todoCollection.todos[indexPath.row]
            todo.finished = true
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath)as! TodoListTableViewCell
            cell.labelCell.text = todo.title
            
            
            let defaults = UserDefaults.standard
            
            // 星ボタンの押したか押してないかを保存
            defaults.set(todo.finished, forKey: "finishedStar")
            
            
            
            
            // スキルの選別をしてlevelBarを増やす
            // skill1の場合
            if cell.labelCell.text == defaults.object(forKey: "skill1Text") as? String {
                
                cell.starButton2.setImage(UIImage(named: "赤星有り.png"), for: .normal)
                
                
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
                defaults.set(todo.finished, forKey: "finishedStar")
                
                self.audioPlayerClear.play()
                
                // Skill2の星ボタンをタップした場合
            } else if cell.labelCell.text == defaults.object(forKey: "skill2Text") as? String{
                
                cell.starButton2.setImage(UIImage(named: "黄星有り.png"), for: .normal)
                
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
                defaults.set(todo.finished, forKey: "finishedStar")
                
                self.audioPlayerClearY.play()
                
                // Skill3の星ボタンを押した場合
            } else if cell.labelCell.text == defaults.object(forKey: "skill3Text") as? String {
                
                cell.starButton2.setImage(UIImage(named: "青星有り.png"), for: .normal)
                
                
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
                
                // 星ボタンの押したか押してないかを保存
                defaults.set(todo.finished, forKey: "finishedStar")
                
                self.audioPlayerClearB.play()
                
            }
            
            
        }
        
        // 配列を全て保存
        self.todoCollection.save()
        
        self.tableView.reloadData()
        
    }
    
    
    
    //    @objc func newTodo() {
    //        self.performSegue(withIdentifier: "PresentNewTodoViewController", sender: self)
    //    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.searchTodoCollection.remove(at: indexPath.row)
            self.todoCollection.todos.remove(at: indexPath.row)
            self.todoCollection.save()
//            self.todoCollection.todos.remove(at: indexPath.row)
//            self.todoCollection.save()
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.middle)
        default:
            return
        }
    }
    
    //    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 70
    //    }
    
    // MARK: サウンドファイル作成
    func makeSound() {
        //Clear音作る。
        //音声ファイルのパスを作る。
        let soundFilePathClear : NSString = Bundle.main.path(forResource: "星ボタン音", ofType: "mp3")! as NSString
        let soundClear : NSURL = NSURL(fileURLWithPath: soundFilePathClear as String)
        //AVAudioPlayerのインスタンス化
        do{
            audioPlayerClear = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("Failed AVAudioPlayer Instance")
        }
        //出来たインスタンスをバッファに保持する。
        audioPlayerClear.prepareToPlay()
    }
    
    func makeSoundY() {
        //Clear音作る。
        //音声ファイルのパスを作る。
        let soundFilePathClear : NSString = Bundle.main.path(forResource: "星ボタン音", ofType: "mp3")! as NSString
        let soundClear : NSURL = NSURL(fileURLWithPath: soundFilePathClear as String)
        //AVAudioPlayerのインスタンス化
        do{
            audioPlayerClearY = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("Failed AVAudioPlayer Instance")
        }
        //出来たインスタンスをバッファに保持する。
        audioPlayerClearY.prepareToPlay()
    }
    
    func makeSoundB() {
        //Clear音作る。
        //音声ファイルのパスを作る。
        let soundFilePathClear : NSString = Bundle.main.path(forResource: "星ボタン音", ofType: "mp3")! as NSString
        let soundClear : NSURL = NSURL(fileURLWithPath: soundFilePathClear as String)
        //AVAudioPlayerのインスタンス化
        do{
            audioPlayerClearB = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("Failed AVAudioPlayer Instance")
        }
        //出来たインスタンスをバッファに保持する。
        audioPlayerClearB.prepareToPlay()
    }

    

    

}
