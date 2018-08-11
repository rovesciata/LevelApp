//
//  CalendarViewController.swift
//  LevelApp
//
//  Created by 門屋　陽二郎 on 2018/06/30.
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic
import AVFoundation


// 星ボタンのセル選択のための機能拡張
public extension UITableView {
    
    func indexPathForView(_ view: UIView) -> IndexPath? {
        // セルの位置を取得
        let height: CGPoint = CGPoint(x: 0, y: 0)
        let viewOrigin = self.convert(height, from: view)
        let indexPath = self.indexPathForRow(at: viewOrigin)
        return indexPath
    }
}

// ディスプレイサイズ取得
let w = UIScreen.main.bounds.size.width
let h = UIScreen.main.bounds.size.height


class CalendarViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance, UITableViewDelegate, UITableViewDataSource {
    
    var audioPlayerClear : AVAudioPlayer! = nil //クリア時用
    var audioPlayerClearY : AVAudioPlayer! = nil //クリア時用
    var audioPlayerClearB: AVAudioPlayer! = nil //クリア時用

    
    @IBOutlet weak var dateView: FSCalendar!
    
    // tableViewを生成
    var exTableView: UITableView = UITableView()
    
    let todoCollection = TodoCollection.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // カレンダーの影
        dateView.layer.shadowOpacity = 0.5
        dateView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        exTableView.frame = CGRect(x: 0, y: 300, width: self.view.bounds.width, height: 330)
        
        // セルの登録
        exTableView.register(UINib(nibName: "TodoListTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoListTableViewCell")
        
        todoCollection.fetchTodos()
        
        //セルの高さを自動で計算
        self.exTableView.estimatedRowHeight = 78
        exTableView.rowHeight = UITableViewAutomaticDimension
        
        exTableView.delegate = self
        exTableView.dataSource  = self
        self.view.addSubview(exTableView)

        //カレンダー設定
        self.dateView.dataSource = self
        self.dateView.delegate = self
        
        // プラスボタン
        // タブバーの高さを取得して、正しい位置にオートレイアウト
        let addBtn = UIButton(frame: CGRect(x: self.view.bounds.width - 100, y: (self.view.bounds.height) - (self.tabBarController?.tabBar.frame.size.height)! - 60, width: 55, height:55))
        addBtn.setTitle("+", for: UIControlState())
        addBtn.titleLabel!.font = UIFont(name: "Helvetica", size: 20)
        addBtn.setTitleColor(.white, for: UIControlState())
        addBtn.backgroundColor = .blue
        addBtn.layer.cornerRadius = addBtn.frame.height/2
        addBtn.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        self.view.addSubview(addBtn)
        addBtn.layer.shadowOpacity = 0.5
        addBtn.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    // プラスボタンの処理
    @objc func onClick(_: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let SecondController = storyboard.instantiateViewController(withIdentifier: "Insert")
        present(SecondController, animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        makeSound()
        makeSoundY()
        makeSoundB()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dayTodos = []
        for todo in todoCollection.todos{
            
            if todo.date == UserDefaults.standard.object(forKey: "dateSection") as? String {
                // tableViewを表示
                exTableView.isHidden = false
                
                let defaults = UserDefaults.standard
                defaults.set(UserDefaults.standard.object(forKey: "dateSection") as? String, forKey: "dateSection")
                
                dayTodos.append(todo)
                
                self.exTableView.reloadData()
                
                if todo.finished == false {
                let tabItem1: UITabBarItem = (self.tabBarController?.tabBar.items![1])!
                tabItem1.badgeValue = "!"
                }
            }
        }
    }
    
    //----------------カレンダー部分----------------------------------------------------
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd"
        return formatter
    }()
    
    // 祝日判定を行い結果を返すメソッド
    func judgeHoliday(_ date : Date) -> Bool {
        // 祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    
    // date型　-> 年月日をIntで取得
    func getDay(_ date: Date) -> (Int, Int, Int) {
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year, month, day)
    }
    
    // 曜日判定
    func getWeekIdx(_ date: Date) -> Int {
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする
        if self.judgeHoliday(date){
            return UIColor.red
        }
        
        // 土日の判定
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {
            return UIColor.red
        }
        else if weekday == 7 {
            return UIColor.blue
        }
        
        return nil
    }

    // 日のTodo配列を宣言
    var dayTodos:[Todo] = []
    
    // カレンダー処理
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        
        let da = "\(year)/\(m)/\(d)"
        
        // tableViewを非表示
        exTableView.isHidden = true
        
        dayTodos = []
        
        for todo in todoCollection.todos{
            // todo.date(タスク実行日)とカレンダーをタップした日付が同じなら処理する。
            if todo.date == da {
                
                exTableView.isHidden = false
                
                let defaults = UserDefaults.standard
                defaults.set(da, forKey: "dateSection")
                // タスクを追加
                dayTodos.append(todo)
                
                self.exTableView.reloadData()
            }
        }
    }

    //-------------TableViewの処理------------------
    
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
        // 日付を表示
        return UserDefaults.standard.object(forKey: "dateSection") as? String
    }
    
    //セクションのタイトルの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dayTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルの内容表示
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath)as! TodoListTableViewCell
        let todo = self.dayTodos[indexPath.row]
        cell.labelCell.text = todo.title
        cell.detailCell.text = todo.descript
        cell.labelCell!.font = UIFont(name: "HirakakuProN-W6", size: 15)
        
        // 星ボタンを押した時
        cell.starButton2.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        
        let defaults = UserDefaults.standard
        
        cell.starButton2.isEnabled = true
        
        cell.redStarImage.isHidden = true
        
        if todo.finished == false {
         
            // 星ボタン(くり抜き)を表示
            if cell.labelCell.text == defaults.object(forKey: "skill1Text") as? String {
                cell.starButton2.setImage(UIImage(named: "赤星中抜き.png"), for: .normal)
            }
            else if cell.labelCell.text == defaults.object(forKey: "skill2Text") as? String {
                cell.starButton2.setImage(UIImage(named: "黄星中抜き.png"), for: .normal)
                
            } else if cell.labelCell.text == defaults.object(forKey: "skill3Text") as? String {
                cell.starButton2.setImage(UIImage(named: "青星中抜き.png"), for: .normal)
                
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
                        cell.redStarImage.image = UIImage(named: "赤星中あり.png")
                        cell.starButton2.addSubview(cell.redStarImage)
                        
                    }
                }
                
            } else if cell.labelCell?.text == defaults.object(forKey: "skill2Text") as? String {
                for todo in todoCollection.todos {
                    if todo.finished == true {
                        cell.starButton2.isEnabled = false
                        cell.redStarImage.isHidden = false
                        cell.redStarImage.image = UIImage(named: "黄星中あり.png")
                        cell.starButton2.addSubview(cell.redStarImage)
                        
                    }
                }
            } else if cell.labelCell?.text == defaults.object(forKey: "skill3Text") as? String {
                for todo in todoCollection.todos {
                    if todo.finished == true {
                        cell.starButton2.isEnabled = false
                        cell.redStarImage.isHidden = false
                        cell.redStarImage.image = UIImage(named: "青星中あり.png")
                        cell.starButton2.addSubview(cell.redStarImage)
                        
                    }
                }
            }
        }
        // 星ボタンの押したか押してないかを保存
        defaults.set(todo.finished, forKey: "finishedStar")
        
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
        
        if let indexPath = self.exTableView.indexPathForView(button) {
            print("Button tapped at indexPath \(indexPath.row)")
            let todo = self.todoCollection.todos[indexPath.row]
            todo.finished = true
            
            let cell = exTableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath)as! TodoListTableViewCell
            cell.labelCell.text = todo.title
            
            
            let defaults = UserDefaults.standard
            
            // 星ボタンの押したか押してないかを保存
            defaults.set(todo.finished, forKey: "finishedStar")
            
            let tabItem: UITabBarItem = (self.tabBarController?.tabBar.items![0])!
            tabItem.badgeValue = "!"
            
            let tabItem1: UITabBarItem = (self.tabBarController?.tabBar.items![1])!
            tabItem1.badgeValue = nil
            
            
            // スキルの選別をしてlevelBarを増やす
            // skill1の場合
            if cell.labelCell.text == defaults.object(forKey: "skill1Text") as? String {
                
                cell.starButton2.setImage(UIImage(named: "赤星中あり.png"), for: .normal)
                
                
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
                
                cell.starButton2.setImage(UIImage(named: "黄星中あり.png"), for: .normal)
                
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
                
                cell.starButton2.setImage(UIImage(named: "青星中あり.png"), for: .normal)
                
                
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
        self.exTableView.reloadData()
        
    }
    
    @objc func newTodo() {
        self.performSegue(withIdentifier: "Insert", sender: self)
    }

    
    // セルの削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:

            var numCell : Int = 0
            for todo in todoCollection.todos{
                // 全セルと特定の日のセルのidが一緒なら削除
                if todo.id == dayTodos[indexPath.row].id {
                    todoCollection.todos.remove(at: numCell)
                }
                numCell += 1
            }
            self.dayTodos.remove(at: indexPath.row)
            
            self.todoCollection.save()
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.middle)
        default:
            return
        }
    }
    
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
