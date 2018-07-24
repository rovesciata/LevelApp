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
    var numTimesYellow = 1
    var numTimesBlue = 1
    var numTimes1 = 1
    var numTimes2 = 1
    var numTimes3 = 1
    
    // 赤矢印ボタンを押した時の処理
    @objc func redTap(_ button: UIButton) {
        
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

            // 全体のlevel数毎の処理
            allUp()

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
                    lvUpBar1(c: "contSkill10to10", d: "countStar1")
                    
                    
                }  else if numSkill1 > 10 && numSkill1 <= 30 {
                    lvUpBar1(c: "countSkill110to30", d:  "countStar110to30")
                    
                    
                }  else if numSkill1 > 30 && numSkill1 <= 50 {
                    lvUpBar1(c: "countSkill130to50", d: "countStar130to50")
                    
                    
                } else if numSkill1 > 50 && numSkill1 <= 70 {
                    lvUpBar1(c: "countSkill150to70", d: "countStar150to70")
                    
                }  else if numSkill1 > 70 && numSkill1 <= 99 {
                    
                    lvUpBar1(c: "countSkill170to99", d: "countStar170to99")
                }
                
                
                // 星ボタンを押した回数を0に戻す
                numTimes1 = 0
                defaults.set(numTimes1, forKey: "numberTimes1")
                
                // レベル数を保存
                defaults.set(numSkill1, forKey: "numCount1")
                // levelBarの値を保存
                defaults.set(levelBarSkill1.progress, forKey: "levelBar1Set")
            }
        }
    }
    
    // 黄矢印ボタンを押した時の処理
    @objc func yellowTap(_ button: UIButton) {
        
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
            
            // 全体のlevel数毎の処理
            allUpY()
            
            // 星ボタンを押した回数を0に戻す
            numTimesYellow = 0
            defaults.set(numTimes, forKey: "numberTimesYellow")
            // レベル数を保存
            defaults.set(num, forKey: "numCount")
            // levelBarの値を保存
            defaults.set(levelBar.progress, forKey: "levelBarSet")
            
            
            // skill2のlevelBarを上げる
            if cell.textLabel?.text == defaults.object(forKey: "skill2Text") as? String {
            
            
            if numSkill2 >= 0 && numSkill2 <= 10 {
                // levelBarを上げる
                lvUpBar2(e: "countSkill20to10", f: "countStar2")
                
            } else if numSkill2 > 10 && numSkill2 <= 30 {
                lvUpBar2(e: "countSkill210to30", f: "countStar210to30")
                
            } else if numSkill2 > 30 && numSkill2 <= 50 {
                lvUpBar2(e: "countSkill230to50", f: "countStar230to50")
                
            } else if numSkill2 > 50 && numSkill2 <= 70 {
                lvUpBar2(e: "countSkill250to70", f: "countStar250to70")
                
            } else if numSkill2 > 70 && numSkill2 <= 99 {
                lvUpBar2(e: "countSkill270to99", f: "countStar270to99")
                
            }
            
            // 星ボタンを押した回数を0に戻す
            numTimes2 = 0
            defaults.set(numTimes2, forKey: "numberTimes2")
            
            // レベル数を保存
            defaults.set(numSkill2, forKey: "numCount2")
            // levelBarの値を保存
            defaults.set(levelBarSkill2.progress, forKey: "levelBar2Set")
        }
    }
        
        
    }
    
    // 青矢印ボタンを押した時の処理
    @objc func blueTap(_ button: UIButton) {
        
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
            
            // 全体のlevel数毎の処理
            allUpB()
            
            // 星ボタンを押した回数を0に戻す
            numTimesBlue = 0
            defaults.set(numTimes, forKey: "numberTimesBlue")
            // レベル数を保存
            defaults.set(num, forKey: "numCount")
            // levelBarの値を保存
            defaults.set(levelBar.progress, forKey: "levelBarSet")
            
            // skill3のlevelBarを上げる
            if cell.textLabel?.text == defaults.object(forKey: "skill3Text") as? String {
               
                if numSkill3 >= 0 && numSkill3 <= 10 {
                    // levelBarを上げる
                    lvUpBar3(g: "countSkill30to10", h: "countStar3")
                    
                } else if numSkill3 > 10 && numSkill3 <= 30 {
                    lvUpBar3(g: "countSkill310to30", h: "countStar310to30")
                    
                } else if numSkill3 > 30 && numSkill3 <= 50 {
                    lvUpBar3(g: "countSkill330to50", h: "countStar330to50")
                    
                } else if numSkill3 > 50 && numSkill3 <= 70 {
                    lvUpBar3(g: "countSkill350to70", h: "countStar350to70")
                    
                } else if numSkill3 > 70 && numSkill3 <= 99 {
                    lvUpBar3(g: "countSkill370to99", h: "countStar370to99")
                    
                }
            
            // 星ボタンを押した回数を0に戻す
            numTimes3 = 0
            defaults.set(numTimes3, forKey: "numberTimes3")
            
            // レベル数を保存
            defaults.set(numSkill3, forKey: "numCount3")
            // levelBarの値を保存
            defaults.set(levelBarSkill3.progress, forKey: "levelBar3Set")
            
        }
    }
        
    }
    
//    func numIf (num: Int ) {
//        if num >= 0 && num <= 10 {
//            lvUpBar3()
//
//        } else if num > 10 && num <= 30 {
//            lvUpBar3()
//
//        } else if num > 30 && num <= 50 {
//            lvUpBar3()
//
//        } else if num > 50 && num <= 70 {
//            lvUpBar3()
//
//        } else if num > 70 && num <= 99 {
//            lvUpBar3()
//
//        }
//    }
    
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
    
    
    // 全体のlevel数毎の処理
    func allUp() {
        if num >= 0 && num <= 10 {
            lvUpBar(a: "count0to10", b: "countStar")
            
        }      else if num > 10 && num <= 30 {
            lvUpBar(a: "count10to30", b: "countStar10to30")
            
        }  else if num > 30 && num <= 50 {
            lvUpBar(a: "count30to50", b: "countStar30to50")
            
        } else if num > 50 && num <= 70 {
            lvUpBar(a: "count50to70", b: "countStar50to70")
            
        }  else if num > 70 && num <= 99 {
            lvUpBar(a: "count70to99", b: "countStar70to99")
        }
    }
    
    func allUpY() {
        if num >= 0 && num <= 10 {
            lvUpBarY(a: "count0to10", b: "countStar")
            
        }      else if num > 10 && num <= 30 {
            lvUpBarY(a: "count10to30", b: "countStar10to30")
            
        }  else if num > 30 && num <= 50 {
            lvUpBarY(a: "count30to50", b: "countStar30to50")
            
        } else if num > 50 && num <= 70 {
            lvUpBarY(a: "count50to70", b: "countStar50to70")
            
        }  else if num > 70 && num <= 99 {
            lvUpBarY(a: "count70to99", b: "countStar70to99")
        }
    }
    
    func allUpB() {
        if num >= 0 && num <= 10 {
            lvUpBarB(a: "count0to10", b: "countStar")
            
        }      else if num > 10 && num <= 30 {
            lvUpBarB(a: "count10to30", b: "countStar10to30")
            
        }  else if num > 30 && num <= 50 {
            lvUpBarB(a: "count30to50", b: "countStar30to50")
            
        } else if num > 50 && num <= 70 {
            lvUpBarB(a: "count50to70", b: "countStar50to70")
            
        }  else if num > 70 && num <= 99 {
            lvUpBarB(a: "count70to99", b: "countStar70to99")
        }
    }
    
    // 全体のlevelbarを上げる
    func lvUpBar(a: String, b: String) {
        let defaults = UserDefaults.standard
        // 星ボタンを押した回数を読み込み
        numTimes = defaults.integer(forKey: "numberTimes")
        
        if levelBar.progress >= 0.0 && levelBar.progress < 0.89 {
            
        let a = defaults.float(forKey: b)
        levelBar.setProgress(levelBar.progress + (a * Float(numTimes)), animated: true)
        
        } else if levelBar.progress >= 0.89 {
            let a = defaults.float(forKey: b)
            levelBar.setProgress(levelBar.progress + (a * Float(numTimes)), animated: true)
        // レベル数を１上げる
        numLevelPlus()
            
    }
    }
    
    func lvUpBarY(a: String, b: String) {
        let defaults = UserDefaults.standard
        // 星ボタンを押した回数を読み込み
        numTimesYellow = defaults.integer(forKey: "numberTimesYellow")
        
        if levelBar.progress >= 0.0 && levelBar.progress < 0.89 {
            
            let a = defaults.float(forKey: b)
            levelBar.setProgress(levelBar.progress + (a * Float(numTimesYellow)), animated: true)
            
        } else if levelBar.progress >= 0.89 {
            let a = defaults.float(forKey: b)
            levelBar.setProgress(levelBar.progress + (a * Float(numTimesYellow)), animated: true)
            // レベル数を１上げる
            numLevelPlus()
            
        }
    }
    
    func lvUpBarB(a: String, b: String) {
        let defaults = UserDefaults.standard
        // 星ボタンを押した回数を読み込み
        numTimesBlue = defaults.integer(forKey: "numberTimesBlue")
        
        if levelBar.progress >= 0.0 && levelBar.progress < 0.89 {
            
            let a = defaults.float(forKey: b)
            levelBar.setProgress(levelBar.progress + (a * Float(numTimesBlue)), animated: true)
            
        } else if levelBar.progress >= 0.89 {
            let a = defaults.float(forKey: b)
            levelBar.setProgress(levelBar.progress + (a * Float(numTimesBlue)), animated: true)
            // レベル数を１上げる
            numLevelPlus()
            
        }
    }
    
    // skill1のlevelBarを上げる
    func lvUpBar1(c: String, d: String) {
        let defaults = UserDefaults.standard
        
        numTimes1 = defaults.integer(forKey: "numberTimes1")
        
        // levelBarの値が0.0〜0.89の間の場合
        if levelBarSkill1.progress >= 0.0 && levelBarSkill1.progress < 0.89 {
            
            let a = defaults.float(forKey: d)
            levelBarSkill1.setProgress(levelBarSkill1.progress + (a * Float(numTimes1)), animated: true)
            
        } else if levelBarSkill1.progress >= 0.89 {
            let a = defaults.float(forKey: d)
            levelBarSkill1.setProgress(levelBarSkill1.progress + (a * Float(numTimes1)), animated: true)
            
            // レベル数を１上げる
            numSkill1Plus()
            
        }
    }
    
    // skill2のlevelBarを上げる
    func lvUpBar2(e: String, f: String) {
        let defaults = UserDefaults.standard
        
        numTimes2 = defaults.integer(forKey: "numberTimes2")
        
        // levelBarの値が0.0〜0.89の間の場合
        if levelBarSkill2.progress >= 0.0 && levelBarSkill2.progress < 0.89 {
            
            let e = defaults.float(forKey: f)
            levelBarSkill2.setProgress(levelBarSkill2.progress + (e * Float(numTimes2)), animated: true)
            
        } else if levelBarSkill2.progress >= 0.89 {
            
            let e = defaults.float(forKey: f)
            levelBarSkill2.setProgress(levelBarSkill2.progress + (e * Float(numTimes2)), animated: true)
            // レベル数を１上げる
            numSkill2Plus()
        
    }
    }
    
    // skill3のlevelBarを上げる
    func lvUpBar3(g: String, h: String) {
        let defaults = UserDefaults.standard
        
        numTimes3 = defaults.integer(forKey: "numberTimes3")
        
        // levelBarの値が0.0〜0.89の間の場合
        if levelBarSkill3.progress >= 0.0 && levelBarSkill3.progress < 0.89 {
            
            let g = defaults.float(forKey: h)
            levelBarSkill3.setProgress(levelBarSkill3.progress + (g * Float(numTimes3)), animated: true)
            
        } else if levelBarSkill3.progress >= 0.89 {
            
            let g = defaults.float(forKey: h)
            levelBarSkill3.setProgress(levelBarSkill3.progress + (g * Float(numTimes3)), animated: true)
            
            numSkill3Plus()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

//        levelUpBtn.isHidden = true
//        let defaults = UserDefaults.standard
//        let trueStar = defaults.bool(forKey: "finishedStar")
//        if trueStar == false {
//            levelUpBtn.isEnabled = false
//        } else {
//            levelUpBtn.isEnabled = true
//        }
        
        let defaults = UserDefaults.standard
        redUpBtn.addTarget(self, action: #selector(self.redTap(_:)), for: .touchUpInside)
        blueUpBtn.addTarget(self, action: #selector(self.blueTap(_:)), for: .touchUpInside)
        yellowUpBtn.addTarget(self, action: #selector(self.yellowTap(_:)), for: .touchUpInside)
        
        // levelAllの現Level数を表示
//        let defaults = UserDefaults.standard
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
        
        
        // 矢印ボタンの表示オン/オフ
        numTimes1 = defaults.integer(forKey: "numberTimes1")
        if numTimes1 >= 1 {
            redUpBtn.isHidden = false
        } else {
            redUpBtn.isHidden = true
        }
        
        numTimes2 = defaults.integer(forKey: "numberTimes2")
        if numTimes2 >= 1 {
            yellowUpBtn.isHidden = false
        } else {
            yellowUpBtn.isHidden = true
        }
        
        numTimes3 = defaults.integer(forKey: "numberTimes3")
        if numTimes3 >= 1 {
            blueUpBtn.isHidden = false
        } else {
            blueUpBtn.isHidden = true
        }
        
        
        // level数の読み込み
        num = defaults.integer(forKey: "numCount")
        numSkill1 = defaults.integer(forKey: "numCount1")
        numSkill2 = defaults.integer(forKey: "numCount2")
        numSkill3 = defaults.integer(forKey: "numCount3")
        
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
    


