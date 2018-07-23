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
    
    
    @IBOutlet weak var levelUpBtn: UIButton!
    
    @IBOutlet weak var redUpBtn: UIButton!
    @IBOutlet weak var yellowUpBtn: UIButton!
    @IBOutlet weak var blueUpBtn: UIButton!
    
    
    
    // level数の初期値を宣言
    var num = 1
    var numSkill1 = 1
    var numSkill2 = 1
    var numSkill3 = 1
    
    var numTimes = 1
    var numTimes1 = 1
    var numTimes2 = 1
    var numTimes3 = 1
    
    // 赤矢印ボタンを押した時の処理
    @objc func redTap(_ button: UIButton) {
        
    }
    
    // 黄矢印ボタンを押した時の処理
    @objc func yellowTap(_ button: UIButton) {
        
    }
    
    // 青矢印ボタンを押した時の処理
    @objc func blueTap(_ button: UIButton) {
        
    }
    
    // 全体のlevel数を１上げる
    func numLevelPlus() {
        num = num + 1
        levelAll.text = String(num)
        levelBar.progress = 0.0
    }
    
    // Skill1のlevel数を1上げる
    func numSkill1Plus() {
        numSkill1 = numSkill1 + 1
        levelSkill1.text = String(numSkill1)
        levelBarSkill1.progress = 0.0
    }
    
    // Skill2のlevel数を１上げる
    func numSkill2Plus() {
        numSkill2 = numSkill2 + 1
        levelSkill2.text = String(numSkill2)
        levelBarSkill2.progress = 0.0
    }
    
    // Skill3のLevel数を１上げる
    func numSkill3Plus() {
        numSkill3 = numSkill3 + 1
        levelSkill3.text = String(numSkill3)
        levelBarSkill3.progress = 0.0
    }
    
    
    // 全体のlevelbarを上げる
    func lvUpBar() {
        let defaults = UserDefaults.standard
        // 星ボタンを押した回数を読み込み
        numTimes = defaults.integer(forKey: "numberTimes")
        
        if levelBar.progress >= 0.0 && levelBar.progress < 0.89 {
            
        let starCount0to10 = defaults.float(forKey: "countStar")
        levelBar.setProgress(levelBar.progress + (starCount0to10 * Float(numTimes)), animated: true)
        
        } else if levelBar.progress >= 0.89 {
        let starCount0to10 = defaults.float(forKey: "countStar")
        levelBar.setProgress(levelBar.progress + (starCount0to10 * Float(numTimes)), animated: true)
        // レベル数を１上げる
        numLevelPlus()
            
    }
        
    }
    
    // skill1のlevelBarを上げる
    func lvUpBar1() {
        let defaults = UserDefaults.standard
        
        numTimes1 = defaults.integer(forKey: "numberTimes1")
        
        // levelBarの値が0.0〜0.89の間の場合
        if levelBarSkill1.progress >= 0.0 && levelBarSkill1.progress < 0.89 {
            
            let starCount10to10 = defaults.float(forKey: "countStar1")
            levelBarSkill1.setProgress(levelBarSkill1.progress + (starCount10to10 * Float(numTimes1)), animated: true)
            
        } else if levelBarSkill1.progress >= 0.89 {
            
            let starCount10to10 = defaults.float(forKey: "countStar1")
            levelBarSkill1.setProgress(levelBarSkill1.progress + (starCount10to10 * Float(numTimes1)), animated: true)
            // レベル数を１上げる
            numSkill1Plus()
    }
    }
    
    // skill2のlevelBarを上げる
    func lvUpBar2() {
        let defaults = UserDefaults.standard
        
        numTimes2 = defaults.integer(forKey: "numberTimes2")
        
        // levelBarの値が0.0〜0.89の間の場合
        if levelBarSkill2.progress >= 0.0 && levelBarSkill2.progress < 0.89 {
            
            let starCount20to10 = defaults.float(forKey: "countStar2")
            levelBarSkill2.setProgress(levelBarSkill2.progress + (starCount20to10 * Float(numTimes2)), animated: true)
            
        } else if levelBarSkill2.progress >= 0.89 {
            
            let starCount20to10 = defaults.float(forKey: "countStar2")
            levelBarSkill2.setProgress(levelBarSkill2.progress + (starCount20to10 * Float(numTimes2)), animated: true)
            // レベル数を１上げる
            numSkill2Plus()
        
    }
    }
    
    // skill3のlevelBarを上げる
    func lvUpBar3() {
        let defaults = UserDefaults.standard
        
        numTimes3 = defaults.integer(forKey: "numberTimes3")
        
        // levelBarの値が0.0〜0.89の間の場合
        if levelBarSkill3.progress >= 0.0 && levelBarSkill3.progress < 0.89 {
            
            let starCount30to10 = defaults.float(forKey: "countStar3")
            levelBarSkill3.setProgress(levelBarSkill3.progress + (starCount30to10 * Float(numTimes3)), animated: true)
            
        } else if levelBarSkill3.progress >= 0.89 {
            
            let starCount30to10 = defaults.float(forKey: "countStar3")
            levelBarSkill3.setProgress(levelBarSkill3.progress + (starCount30to10 * Float(numTimes3)), animated: true)
            
            numSkill3Plus()
        }
    }
    
    
    
    
    
    
    
    

    
    @objc func levelTap(_ button: UIButton) {
        

        // 星ボタン完了カウント数の読み込み
        let defaults = UserDefaults.standard
        // 星ボタンが押されたかどうか判別
        let trueStar = defaults.bool(forKey: "finishedStar")
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        

        // 星ボタンが押されたかどうか判別
                if trueStar == false {
                    
                } else {
                    
                    // 全体のlevelBarを上げる
                    // 選択されたスキルのLabelを読み込む
                    cell.textLabel?.text = defaults.object(forKey: "text1") as? String
                
                        if num >= 0 && num <= 10 {
                            lvUpBar()
                            
                    }      else if num > 10 && num <= 30 {
                            lvUpBar()
                            
                        }  else if num > 30 && num <= 50 {
                            lvUpBar()
                            
                        } else if num > 50 && num <= 70 {
                            lvUpBar()
                            
                        }  else if num > 70 && num <= 99 {
                            lvUpBar()
                    }
                    
                    // 星ボタンを押した回数を0に戻す
                    numTimes = 0
                    defaults.set(numTimes, forKey: "numberTimes")
                            // レベル数を保存
                            defaults.set(num, forKey: "numCount")
                            // levelBarの値を保存
                            defaults.set(levelBar.progress, forKey: "levelBarSet")
                    
                    
                    // skill1のlevelBarを上げる
                    if cell.textLabel?.text == defaults.object(forKey: "skill1Text") as? String {
                        
                        if numSkill1 >= 0 && numSkill1 <= 10 {
                            // levelBarを上げる
                            lvUpBar1()
                            
                        }  else if numSkill1 > 10 && numSkill1 <= 30 {
                            
                            lvUpBar1()
                           
                        }  else if numSkill1 > 30 && numSkill1 <= 50 {
                            
                            lvUpBar1()
                            
                        } else if numSkill1 > 50 && numSkill1 <= 70 {
                            
                            lvUpBar1()
                        }  else if numSkill1 > 70 && numSkill1 <= 99 {
                            
                            lvUpBar1()
                        }
                        
                        // 星ボタンを押した回数を0に戻す
                        numTimes1 = 0
                        defaults.set(numTimes1, forKey: "numberTimes1")
                        
                        // レベル数を保存
                        defaults.set(numSkill1, forKey: "numCount1")
                        // levelBarの値を保存
                        defaults.set(levelBarSkill1.progress, forKey: "levelBar1Set")
            
                        
                    // skill2のlevelBarを上げる
                    } else if cell.textLabel?.text == defaults.object(forKey: "skill2Text") as? String {
                        
                        
                        if numSkill2 >= 0 && numSkill2 <= 10 {
                            // levelBarを上げる
                            lvUpBar2()
                            
                        } else if numSkill2 > 10 && numSkill2 <= 30 {
                            lvUpBar2()
                            
                            } else if numSkill2 > 30 && numSkill2 <= 50 {
                               lvUpBar2()
                            
                            } else if numSkill2 > 50 && numSkill2 <= 70 {
                                lvUpBar2()
                            
                            } else if numSkill2 > 70 && numSkill2 <= 99 {
                                lvUpBar2()
                            
                            }
                        
                        // 星ボタンを押した回数を0に戻す
                        numTimes2 = 0
                        defaults.set(numTimes2, forKey: "numberTimes2")
                        
                        // レベル数を保存
                        defaults.set(numSkill2, forKey: "numCount2")
                        // levelBarの値を保存
                        defaults.set(levelBarSkill2.progress, forKey: "levelBar2Set")
                        
                    // skill3のlevelBarを上げる
                    } else if cell.textLabel?.text == defaults.object(forKey: "skill3Text") as? String {
                        
                        
                            if numSkill3 >= 0 && numSkill3 <= 10 {
                                lvUpBar3()
                                
                            } else if numSkill3 > 10 && numSkill3 <= 30 {
                                lvUpBar3()
                                
                            } else if numSkill3 > 30 && numSkill3 <= 50 {
                                lvUpBar3()
                                
                            } else if numSkill3 > 50 && numSkill3 <= 70 {
                                lvUpBar3()
                                
                            } else if numSkill3 > 70 && numSkill3 <= 99 {
                                lvUpBar3()
                                
                            }
                        
                        // 星ボタンを押した回数を0に戻す
                        numTimes3 = 0
                        defaults.set(numTimes3, forKey: "numberTimes3")
                        
                        // レベル数を保存
                        defaults.set(numSkill3, forKey: "numCount3")
                        // levelBarの値を保存
                        defaults.set(levelBarSkill3.progress, forKey: "levelBar3Set")
                 
                        }
                    
//                    sender.isEnabled = false
                        }
                        
                        }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 星ボタンを押された後、タップボタンを押したときの処理
        levelUpBtn.addTarget(self, action: #selector(self.levelTap(_:)), for: .touchUpInside)
//        levelUpBtn.isHidden = true
//        let defaults = UserDefaults.standard
//        let trueStar = defaults.bool(forKey: "finishedStar")
//        if trueStar == false {
//            levelUpBtn.isEnabled = false
//        } else {
//            levelUpBtn.isEnabled = true
//        }
        
        redUpBtn.addTarget(self, action: #selector(self.redTap(_:)), for: .touchUpInside)
        blueUpBtn.addTarget(self, action: #selector(self.blueTap(_:)), for: .touchUpInside)
        yellowUpBtn.addTarget(self, action: #selector(self.yellowTap(_:)), for: .touchUpInside)
        
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
//        levelAll.text = defaults.object(forKey: "numCount") as? String
        
        num = defaults.integer(forKey: "numCount")
        numSkill1 = defaults.integer(forKey: "numCount1")
        numSkill2 = defaults.integer(forKey: "numCount2")
        numSkill3 = defaults.integer(forKey: "numCount3")
//        levelSkill1.text = defaults.object(forKey: "numCount1") as? String
//        levelSkill2.text = defaults.object(forKey: "numCount2") as? String
//        levelSkill3.text = defaults.object(forKey: "numCount3") as? String
        
        
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
    


