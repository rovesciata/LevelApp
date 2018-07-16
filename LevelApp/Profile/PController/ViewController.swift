//
//  ViewController.swift
//  LevelApp
//
//  Created by 門屋　陽二郎 on 2018/06/21.
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // ViewControllerクラスのプロパティとしてProfileCollectionクラスのインスタンスを宣言
    let profileCollection = ProfileCollection()
    
    @IBOutlet weak var levelBar: UIProgressView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var skill1: UILabel!
    @IBOutlet weak var skill2: UILabel!
    @IBOutlet weak var skill3: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var levelAll: UILabel!
    @IBOutlet weak var levelSkill1: UILabel!
    @IBOutlet weak var levelSkill2: UILabel!
    @IBOutlet weak var levelSkill3: UILabel!
    
    
   
    let floatNum: Float = 0.0
    
    
    
    @IBAction func testBtn(_ sender: UIButton) {
        // 現在の進捗に50%を加算する。
//        levelBar.setProgress(levelBar.progress + 0.5, animated: true)
        // 星ボタン完了カウント数の読み込み
        let defaults = UserDefaults.standard
        let trueStar = defaults.bool(forKey: "finishedStar")
        
        
        
        var num = 1
        
        
        
////        // lv.1〜99までleverBarを上げる
        for num in 1...99 {
            
            while floatNum < 1.0  {
                if trueStar == false {
                    // レベルバーを初期値に戻す
                    //                levelBar = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
                    
                    
                } else {
                    
                    
                    
                    let starCount = defaults.float(forKey: "countStar")
                    levelBar.setProgress(starCount, animated: true)
                    //        levelBar.progress = starCount
                }

            }
            let num = num + 1
            levelAll.text = String(num)

        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // levelBarの高さ変更
        levelBar.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        // levelBarの角丸
        // levelBar.layer.cornerRadius = 5
        // levelBarの枠
        levelBar.layer.borderWidth = 0.3
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Home画面からProfile編集画面への遷移
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.navigationBar.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "編集", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.newProfile))
        
        // userDefaultsの読み込み
        let defaults = UserDefaults.standard
        name.text = defaults.object(forKey: "nameText") as? String
        skill1.text = defaults.object(forKey: "skill1Text") as? String
        skill2.text = defaults.object(forKey: "skill2Text") as? String
        skill3.text = defaults.object(forKey: "skill3Text") as? String
        
        // imageViewのuserDefaultsはNSデータ型にしてから読み込み
        if let imageData:NSData = UserDefaults.standard.object(forKey: "selectImage") as? NSData
        {
            profileImage.image = UIImage(data: imageData as Data)
        }
    }
    
    
    // 編集ボタンを押された時の処理
    @objc func newProfile() {
        self.performSegue(withIdentifier: "PresentNewProfileViewController", sender: self)
    }
        
    }
    


