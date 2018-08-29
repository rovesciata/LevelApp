//
//  NewProfileViewController.swift
//  LevelApp
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit
import GoogleMobileAds

class NewProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate ,UINavigationControllerDelegate, GADBannerViewDelegate {
    
    var bannerView: GADBannerView!
    
    // スクロールビュー
    @IBOutlet weak var myScrollView: UIScrollView!
    // スクロールビューのサブビュー
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var skill1Field: UITextField!
    @IBOutlet weak var skill2Field: UITextField!
    @IBOutlet weak var skill3Field: UITextField!
    // プロフィール写真
    @IBOutlet weak var selectImageView: UIImageView!
    
    // 編集中のテキストフィールド
    var editingField:UITextField?
    // 重なっている高さ
    var overlap: CGFloat = 0.0
    var lastOffsetY: CGFloat = 0.0
    
    // キーボードの被り直し
    // 編集開始のデリゲートメソッド
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 編集中のテキストフィールド
        editingField = textField
    }
    
    // 編集終了のデリゲートメソッド
    func textFieldDidEndEditing(_ textField: UITextField) {
        editingField = nil
    }
    
    // 改行の入力のデリゲートメソッド
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true) // キーボードを下げる
        // 改行コードは入力しない
//        return false
        
        // キーボードを閉じる
        nameField.resignFirstResponder()
        skill1Field.resignFirstResponder()
        skill2Field.resignFirstResponder()
        skill3Field.resignFirstResponder()
        return true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        addBannerViewToView(bannerView)
        
        // キーボードの被り直し
        // スワイプでスクロールさせたならばキーボードを下げる
        myScrollView.keyboardDismissMode = .onDrag
        // スクロールビューの領域を指定する
        let scrollFrame = CGRect(x: 0, y: 77, width: view.frame.width, height: view.frame.height-20)
        myScrollView.frame = scrollFrame
        // コンテンツのサイズを指定する
        let contentRect = contentView.bounds
        myScrollView.contentSize = CGSize(width: contentRect.width, height: contentRect.height)

        // タップしたらキーボードが消える
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewProfileViewController.tapGesture(_:)))
        self.view.addGestureRecognizer(tapRecognizer)
        // デリゲートを設定
        nameField.delegate = self
        skill1Field.delegate = self
        skill2Field.delegate = self
        skill3Field.delegate = self
        
        // デフォルトの通知センターを得る
        let notification = NotificationCenter.default
        // キーボードのframeが変化した
        notification.addObserver(self,
                                 selector: #selector(NewProfileViewController.keyboardChangeFrame(_:)),
                                 name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        // キーボードが登場する
        notification.addObserver(self,
                                 selector: #selector(NewProfileViewController.keyboardWillShow(_:)),
                                 name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        // キーボードが退場した
        notification.addObserver(self,
                                 selector: #selector(NewProfileViewController.keyboardDidHide(_:)),
                                 name: NSNotification.Name.UIKeyboardDidHide, object: nil)
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
   
    // キーボードのframeが変化した通知を受けた
    @objc func keyboardChangeFrame(_ notification: Notification) {  // 通知で実行するイベントハンドラ
        // 編集中のテキストフィールドがない場合は中断する
        guard let nameField = editingField else {
            return
        }
        guard let skill1Field = editingField else {
            return
        }
        guard let skill2Field = editingField else {
            return
        }
        guard let skill3Field = editingField else {
            return
        }
        // キーボードのframeを調べる
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        // テキストフィールドのframeをキーボードと同じ座標軸にする
        let nameFieldFrame = view.convert(nameField.frame, from: contentView)
        _ = view.convert(skill1Field.frame, from: contentView)
        _ = view.convert(skill2Field.frame, from: contentView)
        _ = view.convert(skill3Field.frame, from: contentView)
        // 編集中のテキストフィールドがキーボードと重なっていないか調べる
        overlap = nameFieldFrame.maxY - keyboardFrame.minY + 20
        if overlap > 0 {
            // キーボードで隠れている分だけスクロールする
            overlap += myScrollView.contentOffset.y  // すでにスクロールしている分を加算する
            myScrollView.setContentOffset(CGPoint(x: 0, y: overlap), animated: true)
        }
    }
    
    // キーボードが登場する通知を受けた
    @objc func keyboardWillShow(_ notification: Notification) {  // 通知で実行するイベントハンドラ
        // 現在のスクロール量を保存しておく
        lastOffsetY = myScrollView.contentOffset.y
    }
    
    // キーボードが退場した通知を受けた
    @objc func keyboardDidHide(_ notification: Notification) {  // 通知で実行するイベントハンドラ
        // スクロールを元に戻す
        myScrollView.setContentOffset(CGPoint(x: 0, y: lastOffsetY), animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 閉じるボタン、完了ボタンを作成
        self.navigationController!.navigationBar.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "キャンセル", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NewProfileViewController.close))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完了", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NewProfileViewController.save))
        
        // 名前、アビリティの読み込み
        let defaults = UserDefaults.standard
        nameField.text = defaults.object(forKey: "nameText") as? String
        skill1Field.text = defaults.object(forKey: "skill1Text") as? String
        skill2Field.text = defaults.object(forKey: "skill2Text") as? String
        skill3Field.text = defaults.object(forKey: "skill3Text") as? String
        // imageViewのuserDefaultsはNSデータ型にしてから読み込み
        if let imageData:NSData = UserDefaults.standard.object(forKey: "selectImage") as? NSData {
        selectImageView.image = UIImage(data: imageData as Data)
    }
    }
    
    // 閉じるボタンが押された時の処理
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 完了ボタンが押された時の処理
    @objc func save() {
        // 空欄の場合はアラート通知を出す
        if nameField.text!.isEmpty || skill1Field.text!.isEmpty || skill2Field.text!.isEmpty || skill3Field.text!.isEmpty{
            let alertView = UIAlertController(title: "エラー", message: "全て記入してください。", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "はい", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        } else {
            // 名前、アビリティを記入
            let profile = Profile()
            profile.name = nameField.text!
            profile.skill1 = skill1Field.text!
            profile.skill2 = skill2Field.text!
            profile.skill3 = skill3Field.text!
            self.dismiss(animated: true, completion: nil)
            
            // 名前、アビリティの保存
            let defaults = UserDefaults.standard
            defaults.set(nameField.text, forKey: "nameText")
            defaults.set(skill1Field.text, forKey: "skill1Text")
            defaults.set(skill2Field.text, forKey: "skill2Text")
            defaults.set(skill3Field.text, forKey: "skill3Text")
            
            // UIImageのuserDefaultsの保存は一度NSデータ型にする必要がある
            defaults.set(UIImageJPEGRepresentation(selectImageView.image!, 0.8), forKey: "selectImage")
        }
    }
    
    // タップしたらキーボードが消える
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        nameField.resignFirstResponder()
        skill1Field.resignFirstResponder()
        skill2Field.resignFirstResponder()
        skill3Field.resignFirstResponder()
    }
    
    // 写真を編集
    @IBAction func tapAlbumButton(_ sender: UIButton) {
        let album = UIImagePickerController()
        album.sourceType = UIImagePickerControllerSourceType.photoLibrary
        album.allowsEditing = true
        album.delegate = self
        self.present(album, animated: true, completion: nil)
        
        let defaults = UserDefaults.standard
        defaults.set(nameField.text, forKey: "nameText")
        defaults.set(skill1Field.text, forKey: "skill1Text")
        defaults.set(skill2Field.text, forKey: "skill2Text")
        defaults.set(skill3Field.text, forKey: "skill3Text")
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]){
        // 再表示
        DispatchQueue.main.async {
            self.selectImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
            self.selectImageView.setNeedsLayout()
        }
        self.dismiss(animated: true, completion: nil)
    }

}
