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
import RealmSwift
import AVFoundation




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

// ディスプレイサイズ取得
let w = UIScreen.main.bounds.size.width
let h = UIScreen.main.bounds.size.height


class CalendarViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance, UITableViewDelegate, UITableViewDataSource {
    

    var audioPlayerClear : AVAudioPlayer! = nil //クリア時用
    

    
    @IBOutlet weak var dateView: FSCalendar!
    
    var exTableView: UITableView = UITableView()
    
    
    let todoCollection = TodoCollection.sharedInstance
    // スケジュール内容
//    let labelDate = UILabel(frame: CGRect(x: 5, y: 580, width: 400, height: 50))
    // 「主なスケジュール」の表示
//    let labelTitle = UILabel(frame: CGRect(x: 0, y: 530, width: 180, height: 50))
    // カレンダー部分
//    let dateView = FSCalendar(frame: CGRect(x: 0, y: 65, width: w, height: 300))
    // 日付の表示
//    let Date = UILabel(frame: CGRect(x: 5, y: 430, width: 200, height: 100))
    
//    let noPlan: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exTableView.frame = CGRect(x: 0, y: 365, width: self.view.bounds.width, height: 300)
        
        
//        noPlan.frame = CGRect(x: 0, y: 365, width: self.view.bounds.width, height: 300)
//        noPlan.backgroundColor = .blue
//        exTableView.addSubview(noPlan)
//        noPlan.isHidden = false
        
        // セルの登録
        exTableView.register(UINib(nibName: "TodoListTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoListTableViewCell")
        
        todoCollection.fetchTodos()
        
        
        //セルの高さを自動で計算
        self.exTableView.estimatedRowHeight = 78
        exTableView.rowHeight = UITableViewAutomaticDimension
        
        exTableView.delegate = self
        exTableView.dataSource  = self
        self.view.addSubview(exTableView)
//
//        //カレンダー設定
        self.dateView.dataSource = self
        self.dateView.delegate = self
//        self.dateView.today = nil
//        self.dateView.tintColor = .red
//        self.view.backgroundColor = .white
//        dateView.backgroundColor = .white
//        view.addSubview(dateView)
        
        // 日付表示設定
//        Date.text = ""
//        Date.font = UIFont.systemFont(ofSize: 60.0)
//        Date.textColor = .black
//        exTableView.addSubview(Date)
        
        // 「主なスケジュール」表示設定
//        labelTitle.text = ""
//        labelTitle.textAlignment = .center
//        labelTitle.font = UIFont.systemFont(ofSize: 20.0)
//        view.addSubview(labelTitle)
        
        // スケジュール内容表示設定
//        labelDate.text = ""
//        labelDate.font = UIFont.systemFont(ofSize: 18.0)
//        view.addSubview(labelDate)
        
        // スケジュール追加ボタン
//        let addBtn = UIButton(frame: CGRect(x: w - 55, y: h - 115, width: 50, height: 50))
//        addBtn.setTitle("+", for: UIControlState())
//        addBtn.setTitleColor(.white, for: UIControlState())
//        addBtn.backgroundColor = .red
//        addBtn.layer.cornerRadius = 25.0
//        addBtn.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
//        view.addSubview(addBtn)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        makeSound()
       
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // ヘッダーボタンを作成
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        self.navigationController!.navigationBar.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新規作成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CalendarViewController.newTodo))
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.exTableView.reloadData()
        
    }
    
    // カレンダー部分
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
    
    
//    @IBAction func playSound() {
//        // 連打した時に連続して音がなるようにする
//        audioPlayerInstance.currentTime = 0         // 再生位置を先頭(0)に戻してから
//        audioPlayerInstance.play()                  // 再生する
//        // パンとボリュームをいじってみる
//        audioPlayerInstance.volume = 0.5            // 小さめの音になる
//        audioPlayerInstance.pan = -1.0              // 左側だけ聴こえるようになる
//    }
    
    // 画面遷移(スケジュール登録ページ)
//    @objc func onClick(_: UIButton) {
////        self.performSegue(withIdentifier: "NewTodoViewController", sender: self)
//
////        self.performSegue(withIdentifier: "PresentNewTodoViewController", sender: self)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let SecondController = storyboard.instantiateViewController(withIdentifier: "Insert")
//        present(SecondController, animated: true, completion: nil)
//    }
    
    
    // 日のTodo配列を宣言
    var dayTodos:[Todo] = []
    // カレンダー処理(スケジュール表示処理)
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        labelTitle.text = "主なスケジュール"
//        labelTitle.backgroundColor = .orange
//        view.addSubview(labelTitle)
        
        // 予定がある場合、スケジュールをDBから取得・表示する。
        // ない場合、「スケジュールはありません」と表示
//        labelDate.text = "スケジュールはありません"
//        labelDate.textColor = .lightGray
        
        
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        
        let da = "\(year)/\(m)/\(d)"
        
//        let defaults = UserDefaults.standard
//        defaults.set(da, forKey: "dateCalendar")
        
        // クリックしたら、日付が表示される
//        Date.text = "\(m)/\(d)"
//        view.addSubview(Date)
        
        
        // スケジュールを取得
        
//        var result = realm.objects(Event.self)
//        result = result.filter("date = '\(da)'")
//        print(result)
//        for ev in result {
//            if ev.date == da {
////                labelDate.text = ev.event
////                labelDate.textColor = .black
////                view.addSubview(labelDate)
//
//            }
//        }
        
        
        
//        let result = UserDefaults.standard.object(forKey: "dateCalendar") as! String
        exTableView.isHidden = true
        dayTodos = []
        for todo in todoCollection.todos{
            
            if todo.date == da {
                
                exTableView.isHidden = false
                
                dayTodos.append(todo)
                
                self.exTableView.reloadData()
            } else {
                
                
            }
        }
    }
    
//    var sectionDate = UserDefaults.standard.object(forKey: "dateCalendar") as? String
    
    
    //-------------TableViewの処理------------------
    
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
        return ""
    }
    
    //セクションのタイトルの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dayTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "myCell")
        
        // セルの内容表示
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath)as! TodoListTableViewCell
        let todo = self.dayTodos[indexPath.row]
        cell.labelCell.text = todo.title
        cell.detailCell.text = todo.descript
        cell.labelCell!.font = UIFont(name: "HirakakuProN-W6", size: 15)
        
        // 星ボタンを押した時
        cell.starButton2.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        
        let defaults = UserDefaults.standard
        
        //        todo.finished = defaults.bool(forKey: "finishedStar")
        let redUpLevel = defaults.bool(forKey: "redUpBool")
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
                
            } else if cell.labelCell?.text == defaults.object(forKey: "skill2Text") as? String {
                cell.starButton2.setImage(UIImage(named: "黄星有り.png"), for: .normal)
            } else if cell.labelCell?.text == defaults.object(forKey: "skill3Text") as? String {
                cell.starButton2.setImage(UIImage(named: "青星有り.png"), for: .normal)
            }
            
            //            cell.starButton2.isEnabled = false
            
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
        
        if let indexPath = self.exTableView.indexPathForView(button) {
            print("Button tapped at indexPath \(indexPath.row)")
            let todo = self.todoCollection.todos[indexPath.row]
            todo.finished = true
            
            let cell = exTableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath)as! TodoListTableViewCell
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
                
            }
            
            
        }
        
        // 配列を全て保存
        self.todoCollection.save()
        
        self.exTableView.reloadData()
        
//        audioPlayerInstance.play()
        
//        if let sound = NSDataAsset(name: "星ボタン音") {
//            let player = try? AVAudioPlayer(data: sound.data)
//            player?.play()
        self.audioPlayerClear.play()
        
        
    }
    
    
    
    @objc func newTodo() {
        self.performSegue(withIdentifier: "Insert", sender: self)
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.todoCollection.todos.remove(at: indexPath.row)
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
        
        //        // 連打した時に連続して音がなるようにする
        //        audioPlayerInstance.currentTime = 0         // 再生位置を先頭(0)に戻してから
        //        audioPlayerInstance.play()                  // 再生する
    }
    
    
    // ＜最初作成したカレンダー＞
    
//    @IBOutlet weak var calendar: FSCalendar!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // デリゲートの設定
//        self.calendar.dataSource = self
//        self.calendar.delegate = self
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
//    fileprivate lazy var dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        return formatter
//    }()
//
//    // 祝日判定を行い結果を返すメソッド(True:祝日)
//    func judgeHoliday(_ date : Date) -> Bool {
//        //祝日判定用のカレンダークラスのインスタンス
//        let tmpCalendar = Calendar(identifier: .gregorian)
//
//        // 祝日判定を行う日にちの年、月、日を取得
//        let year = tmpCalendar.component(.year, from: date)
//        let month = tmpCalendar.component(.month, from: date)
//        let day = tmpCalendar.component(.day, from: date)
//
//        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
//        let holiday = CalculateCalendarLogic()
//
//        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
//    }
//    // date型 -> 年月日をIntで取得
//    func getDay(_ date:Date) -> (Int,Int,Int){
//        let tmpCalendar = Calendar(identifier: .gregorian)
//        let year = tmpCalendar.component(.year, from: date)
//        let month = tmpCalendar.component(.month, from: date)
//        let day = tmpCalendar.component(.day, from: date)
//        return (year,month,day)
//    }
//
//    //曜日判定(日曜日:1 〜 土曜日:7)
//    func getWeekIdx(_ date: Date) -> Int{
//        let tmpCalendar = Calendar(identifier: .gregorian)
//        return tmpCalendar.component(.weekday, from: date)
//    }
//
//    // 土日や祝日の日の文字色を変える
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
//        //祝日判定をする（祝日は赤色で表示する）
//        if self.judgeHoliday(date){
//            return UIColor.red
//        }
//
//        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
//        let weekday = self.getWeekIdx(date)
//        if weekday == 1 {   //日曜日
//            return UIColor.red
//        }
//        else if weekday == 7 {  //土曜日
//            return UIColor.blue
//        }
//
//        return nil
//    }
//
//    // カレンダータップイベントの取得
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
////
////        // 上記の関数に以下のコードを追加することで、タッチした日付を取得できます。
//        let selectDay = getDay(date)
//    }
//
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
