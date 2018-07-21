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
    @IBOutlet weak var levelBarSkill1: UIProgressView!
    @IBOutlet weak var levelBarSkill2: UIProgressView!
    @IBOutlet weak var levelBarSkill3: UIProgressView!
    
    
    
    // level数の初期値を宣言
    var num = 1
    var numSkill1 = 1
    var numSkill2 = 1
    var numSkill3 = 1
    
    
    
    
    // 星ボタンを押された後、タップボタンを押したときの処理
    @IBAction func testBtn(_ sender: UIButton) {
        
            
        
        // 現在の進捗に50%を加算する。
//        levelBar.setProgress(levelBar.progress + 0.5, animated: true)
        // 星ボタン完了カウント数の読み込み
        let defaults = UserDefaults.standard
        // 星ボタンが押されたかどうか判別
        let trueStar = defaults.bool(forKey: "finishedStar")
        
        // levelBarとlevelの値の読み込み
//        levelBar.progress = defaults.float(forKey: "levelBarSet")
        
//        levelBarSkill1.progress = defaults.float(forKey: "levelBar1Set")
//        numSkill1 = defaults.integer(forKey: "numCount1")
//        levelBarSkill2.progress = defaults.float(forKey: "levelBar2Set")
//        numSkill2 = defaults.integer(forKey: "numCount2")
//        levelBarSkill3.progress = defaults.float(forKey: "levelBar3Set")
//        numSkill3 = defaults.integer(forKey: "numCount3")
        
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        
////        // lv.1〜99までleverBarを上げる
//        for num in 1...98 {
        // 星ボタンが押されたかどうか判別
                if trueStar == false {
                    
                    
                } else {
                    // 全体のlevelBarを上げる
                    // 選択されたスキルのLabelを読み込む
                    cell.textLabel?.text = defaults.object(forKey: "text1") as? String
                    // 星ボタンを押した値を読み込む
                    let starCount = defaults.float(forKey: "countStar")
                    // levelBarの値が0.0〜0.89の間の場合
                    if levelBar.progress >= 0.0 && levelBar.progress < 0.89 {
                    // levelBarの値を増やす
                    levelBar.setProgress(levelBar.progress + starCount, animated: true)
                    // levelBarの値を保存
                    defaults.set(levelBar.progress, forKey: "levelBarSet")
                   
                    } else if levelBar.progress >= 0.89 {
                        levelBar.setProgress(levelBar.progress + starCount, animated: true)
                        num = num + 1
                        levelAll.text = String(num)
                        levelBar.progress = 0.0
                        
                        // レベル数を保存
                        defaults.set(levelAll.text, forKey: "numCount")
                        // levelBarの値を保存
                        defaults.set(levelBar.progress, forKey: "levelBarSet")
                    }
                    
                    // skill1のlevelBarを上げる
                    if cell.textLabel?.text == defaults.object(forKey: "skill1Text") as? String {
                        
                        if levelBarSkill1.progress >= 0.0 && levelBarSkill1.progress < 0.89 {
                        let starCount1 = defaults.float(forKey: "countStar1")
                        levelBarSkill1.setProgress(levelBarSkill1.progress + starCount1, animated: true)
                        
                            // levelBarの値を保存
                            defaults.set(levelBarSkill1.progress, forKey: "levelBar1Set")
                            
                    } else if levelBarSkill1.progress >= 0.89 {
                            
                            let starCount1 = defaults.float(forKey: "countStar1")
                            levelBarSkill1.setProgress(levelBarSkill1.progress + starCount1, animated: true)
                            
                                numSkill1 = numSkill1 + 1
                                levelSkill1.text = String(numSkill1)
                                levelBarSkill1.progress = 0.0
                            
                            // levelBarの値を保存
                            defaults.set(levelBarSkill1.progress, forKey: "levelBar1Set")
                        
                            // レベル数を保存
                            defaults.set(numSkill1, forKey: "numCount1")

                        }
            
                        
                    // skill2のlevelBarを上げる
                    } else if cell.textLabel?.text == defaults.object(forKey: "skill2Text") as? String {
                        
                        if levelBarSkill2.progress >= 0.0 && levelBarSkill2.progress < 0.89 {
                        let starCount2 = defaults.float(forKey: "countStar2")
                        levelBarSkill2.setProgress(levelBarSkill2.progress + starCount2, animated: true)
                            
                        // levelBarの値を保存
                        defaults.set(levelBarSkill2.progress, forKey: "levelBar2Set")
                            
                        } else if levelBarSkill2.progress >= 0.89 {
                            
                            let starCount2 = defaults.float(forKey: "countStar2")
                            levelBarSkill2.setProgress(levelBarSkill2.progress + starCount2, animated: true)
                            
                            numSkill2 = numSkill2 + 1
                            levelSkill2.text = String(numSkill2)
                            levelBarSkill2.progress = 0.0
                            
                            // levelBarの値を保存
                            defaults.set(levelBarSkill2.progress, forKey: "levelBar2Set")
                            // レベル数を保存
                            defaults.set(levelSkill2.text, forKey: "numCount2")
                        }
                    // skill3のlevelBarを上げる
                    } else if cell.textLabel?.text == defaults.object(forKey: "skill3Text") as? String {
                        
                        if levelBarSkill3.progress >= 0.0 && levelBarSkill3.progress < 0.89 {
                        let starCount3 = defaults.float(forKey: "countStar3")
                        levelBarSkill3.setProgress(levelBarSkill3.progress + starCount3, animated: true)
                        
                        // levelBarの値を保存
                        defaults.set(levelBarSkill3.progress, forKey: "levelBar3Set")
                            
                        } else if levelBarSkill3.progress >= 0.89 {
                            
                            let starCount3 = defaults.float(forKey: "countStar3")
                            levelBarSkill3.setProgress(levelBarSkill3.progress + starCount3, animated: true)
                            
                            numSkill3 = numSkill3 + 1
                            levelSkill3.text = String(numSkill3)
                            levelBarSkill3.progress = 0.0
                            
                            // levelBarの値を保存
                            defaults.set(levelBarSkill3.progress, forKey: "levelBar3Set")
                            // レベル数を保存
                            defaults.set(levelSkill3.text, forKey: "numCount3")
                        }
                        
                        
                    }
                    
                    
                    
                    
                    
//                    sender.isEnabled = false
                    
                    // levelBarの値とlevelの値をuserDefaultsで保存
//                    let defaults = UserDefaults.standard
//                    defaults.set(levelBar.setProgress, forKey: "levelBarSet")
//                    defaults.set(num, forKey: "numCount")
//                    defaults.set(levelBarSkill1.setProgress, forKey: "levelBar1Set")
//                    defaults.set(numSkill1, forKey: "numCount1")
//                    defaults.set(levelBarSkill2.setProgress, forKey: "levelBar2Set")
//                    defaults.set(numSkill2, forKey: "numCount2")
//                    defaults.set(levelBarSkill3.setProgress, forKey: "levelBar3Set")
//                    defaults.set(numSkill3, forKey: "numCount3")
                    
            }
    }
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // levelAllの現Level数を表示
        let defaults = UserDefaults.standard
        num = defaults.integer(forKey: "numCount")
        levelAll.text = String(num)
        
        // skill1の現Level数を表示
        numSkill1 = defaults.integer(forKey: "numCount1")
        levelSkill1.text = String(numSkill1)
        
        // skill2の現Level数を表示
        numSkill2 = defaults.integer(forKey: "numCount2")
        levelSkill2.text = String(numSkill2)
        
        // skill3の現Level数を表示
        numSkill3 = defaults.integer(forKey: "numCount3")
        levelSkill3.text = String(numSkill3)
        
        // levelBarの高さ変更
        levelBar.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        // levelBarの角丸
        // levelBar.layer.cornerRadius = 5
        // levelBarの枠
        levelBar.layer.borderWidth = 0.3
        
        // levelBarSkill1の高さ変更
        levelBarSkill1.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        levelBarSkill1.layer.borderWidth = 0.3
        
        // levelBarSkill2の高さ変更
        levelBarSkill2.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        levelBarSkill2.layer.borderWidth = 0.3
        
        // levelBarSkill3の高さ変更
        levelBarSkill3.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        levelBarSkill3.layer.borderWidth = 0.3
        
        
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
        
        // level数の読み込み
        levelAll.text = defaults.object(forKey: "numCount") as? String
        
        
        numSkill1 = defaults.integer(forKey: "numCount1")
        
//        levelSkill1.text = defaults.object(forKey: "numCount1") as? String
        levelSkill2.text = defaults.object(forKey: "numCount2") as? String
        levelSkill3.text = defaults.object(forKey: "numCount3") as? String
        
        
        // levelbarの値の読み込み
        levelBar.progress = defaults.float(forKey: "levelBarSet")
        levelBarSkill1.progress = defaults.float(forKey: "levelBar1Set")
        levelBarSkill2.progress = defaults.float(forKey: "levelBar2Set")
        levelBarSkill3.progress = defaults.float(forKey: "levelBar3Set")
        
        
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
    


