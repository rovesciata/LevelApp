//
//  EventViewController.swift
//  LevelApp
//
//  Copyright © 2018年 cagioro. All rights reserved.
//


import UIKit
import GoogleMobileAds


class EventViewController: UIViewController, GADBannerViewDelegate {
    
    var bannerView: GADBannerView!
    
    var date: String!
    
    //ディスプレイサイズ取得
    let w2 = UIScreen.main.bounds.size.width
    let h2 = UIScreen.main.bounds.size.height
    
    //日付フォーム(UIDatePickerを使用)
    let y = UIDatePicker(frame: CGRect(x: 0, y: 400, width: UIScreen.main.bounds.size.width, height: 100))
    //日付表示
//    let y_text = UILabel(frame: CGRect(x: 90, y: 343, width: 150, height: 30))
    
    let todoCollection = TodoCollection.sharedInstance
    
    @IBOutlet weak var y_text: UILabel!
    @IBOutlet weak var skillSelectedLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        addBannerViewToView(bannerView)
        
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
        
        // 保存ボタン
        let eventInsert = UIButton(frame: CGRect(x: self.view.bounds.width - 80, y: 50, width: 70, height: 25))
        eventInsert.setTitle("保存", for: UIControlState())
        eventInsert.setTitleColor(.black, for: UIControlState())
        eventInsert.backgroundColor = .white
        eventInsert.layer.cornerRadius = 5.0
        eventInsert.layer.borderColor = UIColor.lightGray.cgColor
        eventInsert.layer.borderWidth = 1.0
        eventInsert.addTarget(self, action: #selector(saveEvent(_:)), for: .touchUpInside)
        view.addSubview(eventInsert)
        
        // キャンセルボタン
        let backBtn = UIButton(frame: CGRect(x: 10, y: 50, width: 50, height: 25))
        backBtn.setTitle("×", for: UIControlState())
        backBtn.setTitleColor(.black, for: UIControlState())
        backBtn.backgroundColor = .white
        backBtn.layer.cornerRadius = 5.0
        backBtn.layer.borderColor = UIColor.lightGray.cgColor
        backBtn.layer.borderWidth = 1.0
        backBtn.addTarget(self, action: #selector(onbackClick(_:)), for: .touchUpInside)
        view.addSubview(backBtn)
        
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    // 4
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    
        @objc func saveEvent(_ : UIButton){
            
            let todo = Todo()
            // アビリティ名をタスク画面に表示
            todo.title = UserDefaults.standard.object(forKey: "text1") as! String
            // 詳細を表示
            todo.descript = descriptionView.text
            todo.finished = false
            // 実行日を表示
            todo.date = self.y_text.text!
            // セルのidを取得
            todo.id = String("\(arc4random())")
            
            self.todoCollection.addTodoCollection(todo: todo)
            print(self.todoCollection.todos)
            
            let todoCollection = TodoCollection.sharedInstance
            todoCollection.save()
            
            
            //前のページに戻る
            dismiss(animated: true, completion: nil)
        }

    //画面遷移(カレンダーページへ戻る)
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        skillSelectedLabel.text =  UserDefaults.standard.object(forKey: "text1") as? String
        
    }
    
    // ×ボタンで閉じる
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // キーボードの完了ボタン処理
    @objc func commitButtonTapped() {
        self.view.endEditing(true)
    }
    
}
