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

    
    @objc func levelTap(_ button: UIButton) {
        

        // 星ボタン完了カウント数の読み込み
        let defaults = UserDefaults.standard
        // 星ボタンが押されたかどうか判別
        let trueStar = defaults.bool(forKey: "finishedStar")
        
        
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        

        // 星ボタンが押されたかどうか判別
                if trueStar == false {
//                    levelUpBtn.isEnabled = false
                    
                } else {
                    
                    
                    // 全体のlevelBarを上げる
                    // 選択されたスキルのLabelを読み込む
                    cell.textLabel?.text = defaults.object(forKey: "text1") as? String
                    
                    
                        
                        if num >= 0 && num <= 10 {
                            // levelBarの値が0.0〜0.89の間の場合
                            if levelBar.progress >= 0.0 && levelBar.progress < 0.89 {
                                
                                numTimes = defaults.integer(forKey: "numberTimes")

                            let starCount0to10 = defaults.float(forKey: "countStar")
                            levelBar.setProgress(levelBar.progress + (starCount0to10 * Float(numTimes)), animated: true)
                                // levelBarの値を保存
                                defaults.set(levelBar.progress, forKey: "levelBarSet")
                            } else if levelBar.progress >= 0.89 {

                                let starCount0to10 = defaults.float(forKey: "countStar")
                                levelBar.setProgress(levelBar.progress + starCount0to10, animated: true)
                            num = num + 1
                            levelAll.text = String(num)
                            levelBar.progress = 0.0

                            // レベル数を保存
                            defaults.set(num, forKey: "numCount")
                            // levelBarの値を保存
                            defaults.set(levelBar.progress, forKey: "levelBarSet")
                            }
                    }           else if num > 10 && num <= 30 {
                                
                                // levelBarの値が0.0〜0.89の間の場合
                                if levelBar.progress >= 0.0 && levelBar.progress < 0.89 {
                                    // 星ボタンを押した値を読み込む
                                    let starCount10to30 = defaults.float(forKey: "countStar10to30")
                                    // levelBarの値を増やす
                                    levelBar.setProgress(levelBar.progress + starCount10to30, animated: true)
                                    // levelBarの値を保存
                                    defaults.set(levelBar.progress, forKey: "levelBarSet")
                            } else if levelBar.progress >= 0.89 {
                                    // 星ボタンを押した値を読み込む
                                    let starCount10to30 = defaults.float(forKey: "countStar10to30")
                                    levelBar.setProgress(levelBar.progress + starCount10to30, animated: true)
                                    num = num + 1
                                    levelAll.text = String(num)
                                    levelBar.progress = 0.0
                        
                        // レベル数を保存
//                        defaults.set(levelAll.text, forKey: "numCount")
                        defaults.set(num, forKey: "numCount")
                        // levelBarの値を保存
                        defaults.set(levelBar.progress, forKey: "levelBarSet")
                    }
                        }  else if num > 30 && num <= 50 {
                            
                            // levelBarの値が0.0〜0.89の間の場合
                            if levelBar.progress >= 0.0 && levelBar.progress < 0.89 {
                                // 星ボタンを押した値を読み込む
                                let starCount30to50 = defaults.float(forKey: "countStar30to50")
                                // levelBarの値を増やす
                                levelBar.setProgress(levelBar.progress + starCount30to50, animated: true)
                                // levelBarの値を保存
                                defaults.set(levelBar.progress, forKey: "levelBarSet")
                            } else if levelBar.progress >= 0.89 {
                                // 星ボタンを押した値を読み込む
                                let starCount30to50 = defaults.float(forKey: "countStar30to50")
                                levelBar.setProgress(levelBar.progress + starCount30to50, animated: true)
                                num = num + 1
                                levelAll.text = String(num)
                                levelBar.progress = 0.0
                                
                                // レベル数を保存
                                //                        defaults.set(levelAll.text, forKey: "numCount")
                                defaults.set(num, forKey: "numCount")
                                // levelBarの値を保存
                                defaults.set(levelBar.progress, forKey: "levelBarSet")
                            }
                    
                        } else if num > 50 && num <= 70 {

                            // levelBarの値が0.0〜0.89の間の場合
                            if levelBar.progress >= 0.0 && levelBar.progress < 0.89 {
                                // 星ボタンを押した値を読み込む
                                let starCount50to70 = defaults.float(forKey: "countStar50to70")
                                // levelBarの値を増やす
                                levelBar.setProgress(levelBar.progress + starCount50to70, animated: true)
                                // levelBarの値を保存
                                defaults.set(levelBar.progress, forKey: "levelBarSet")
                            } else if levelBar.progress >= 0.89 {
                                // 星ボタンを押した値を読み込む
                                let starCount50to70 = defaults.float(forKey: "countStar50to70")
                                levelBar.setProgress(levelBar.progress + starCount50to70, animated: true)
                                num = num + 1
                                levelAll.text = String(num)
                                levelBar.progress = 0.0

                                // レベル数を保存
                                //                        defaults.set(levelAll.text, forKey: "numCount")
                                defaults.set(num, forKey: "numCount")
                                // levelBarの値を保存
                                defaults.set(levelBar.progress, forKey: "levelBarSet")
                            }
                        }  else if num > 70 && num <= 99 {
                            
                            // levelBarの値が0.0〜0.89の間の場合
                            if levelBar.progress >= 0.0 && levelBar.progress < 0.89 {
                                // 星ボタンを押した値を読み込む
                                let starCount70to99 = defaults.float(forKey: "countStar70to99")
                                // levelBarの値を増やす
                                levelBar.setProgress(levelBar.progress + starCount70to99, animated: true)
                                // levelBarの値を保存
                                defaults.set(levelBar.progress, forKey: "levelBarSet")
                            } else if levelBar.progress >= 0.89 {
                                // 星ボタンを押した値を読み込む
                                let starCount70to99 = defaults.float(forKey: "countStar70to99")
                                levelBar.setProgress(levelBar.progress + starCount70to99, animated: true)
                                num = num + 1
                                levelAll.text = String(num)
                                levelBar.progress = 0.0
                                
                                // レベル数を保存
                                //                        defaults.set(levelAll.text, forKey: "numCount")
                                defaults.set(num, forKey: "numCount")
                                // levelBarの値を保存
                                defaults.set(levelBar.progress, forKey: "levelBarSet")
                            }
                    }
                    
                    
                    // skill1のlevelBarを上げる
                    if cell.textLabel?.text == defaults.object(forKey: "skill1Text") as? String {
                        
                    
                        if numSkill1 >= 0 && numSkill1 <= 10 {
                            
                            numTimes1 = defaults.integer(forKey: "numberTimes1")
                            
                            // levelBarの値が0.0〜0.89の間の場合
                            if levelBarSkill1.progress >= 0.0 && levelBarSkill1.progress < 0.89 {
                                
                                let starCount10to10 = defaults.float(forKey: "countStar1")
                                levelBarSkill1.setProgress(levelBarSkill1.progress + (starCount10to10 * Float(numTimes1)), animated: true)
                                // levelBarの値を保存
                                defaults.set(levelBarSkill1.progress, forKey: "levelBar1Set")
                            } else if levelBarSkill1.progress >= 0.89 {
                                
                                let starCount10to10 = defaults.float(forKey: "countStar")
                                levelBarSkill1.setProgress(levelBarSkill1.progress + (starCount10to10 * Float(numTimes1)), animated: true)
                                numSkill1 = numSkill1 + 1
                                levelSkill1.text = String(numSkill1)
                                levelBarSkill1.progress = 0.0
                                
                                // レベル数を保存
                                defaults.set(numSkill1, forKey: "numCount1")
                                // levelBarの値を保存
                                defaults.set(levelBarSkill1.progress, forKey: "levelBar1Set")
                            }
                        }           else if numSkill1 > 10 && numSkill1 <= 30 {
                            
                            // levelBarの値が0.0〜0.89の間の場合
                            if levelBarSkill1.progress >= 0.0 && levelBarSkill1.progress < 0.89 {
                                // 星ボタンを押した値を読み込む
                                let starCount110to30 = defaults.float(forKey: "countStar110to30")
                                // levelBarの値を増やす
                                levelBarSkill1.setProgress(levelBarSkill1.progress + starCount110to30, animated: true)
                                // levelBarの値を保存
                                defaults.set(levelBarSkill1.progress, forKey: "levelBar1Set")
                            } else if levelBarSkill1.progress >= 0.89 {
                                // 星ボタンを押した値を読み込む
                                let starCount110to30 = defaults.float(forKey: "countStar110to30")
                                levelBarSkill1.setProgress(levelBarSkill1.progress + starCount110to30, animated: true)
                                numSkill1 = numSkill1 + 1
                                levelSkill1.text = String(numSkill1)
                                levelBarSkill1.progress = 0.0
                                
                                // レベル数を保存
                                //                        defaults.set(levelAll.text, forKey: "numCount")
                                defaults.set(num, forKey: "numCount1")
                                // levelBarの値を保存
                                defaults.set(levelBarSkill1.progress, forKey: "levelBar1Set")
                            }
                        }  else if numSkill1 > 30 && numSkill1 <= 50 {
                            
                            // levelBarの値が0.0〜0.89の間の場合
                            if levelBarSkill1.progress >= 0.0 && levelBarSkill1.progress < 0.89 {
                                // 星ボタンを押した値を読み込む
                                let starCount130to50 = defaults.float(forKey: "countStar130to50")
                                // levelBarの値を増やす
                                levelBarSkill1.setProgress(levelBarSkill1.progress + starCount130to50, animated: true)
                                // levelBarの値を保存
                                defaults.set(levelBarSkill1.progress, forKey: "levelBar1Set")
                            } else if levelBarSkill1.progress >= 0.89 {
                                // 星ボタンを押した値を読み込む
                                let starCount130to50 = defaults.float(forKey: "countStar130to50")
                                levelBarSkill1.setProgress(levelBarSkill1.progress + starCount130to50, animated: true)
                                numSkill1 = numSkill1 + 1
                                levelSkill1.text = String(numSkill1)
                                levelBarSkill1.progress = 0.0
                                
                                // レベル数を保存
                                //                        defaults.set(levelAll.text, forKey: "numCount")
                                defaults.set(num, forKey: "numCount1")
                                // levelBarの値を保存
                                defaults.set(levelBarSkill1.progress, forKey: "levelBar1Set")
                            }
                            
                        } else if numSkill1 > 50 && numSkill1 <= 70 {
                            
                            // levelBarの値が0.0〜0.89の間の場合
                            if levelBarSkill1.progress >= 0.0 && levelBarSkill1.progress < 0.89 {
                                // 星ボタンを押した値を読み込む
                                let starCount150to70 = defaults.float(forKey: "countStar150to70")
                                // levelBarの値を増やす
                                levelBarSkill1.setProgress(levelBarSkill1.progress + starCount150to70, animated: true)
                                // levelBarの値を保存
                                defaults.set(levelBarSkill1.progress, forKey: "levelBar1Set")
                            } else if levelBarSkill1.progress >= 0.89 {
                                // 星ボタンを押した値を読み込む
                                let starCount150to70 = defaults.float(forKey: "countStar150to70")
                                levelBarSkill1.setProgress(levelBarSkill1.progress + starCount150to70, animated: true)
                                numSkill1 = numSkill1 + 1
                                levelSkill1.text = String(numSkill1)
                                levelBarSkill1.progress = 0.0
                                
                                // レベル数を保存
                                //                        defaults.set(levelAll.text, forKey: "numCount")
                                defaults.set(num, forKey: "numCount1")
                                // levelBarの値を保存
                                defaults.set(levelBarSkill1.progress, forKey: "levelBar1Set")
                            }
                        }  else if numSkill1 > 70 && numSkill1 <= 99 {
                            
                            // levelBarの値が0.0〜0.89の間の場合
                            if levelBarSkill1.progress >= 0.0 && levelBarSkill1.progress < 0.89 {
                                // 星ボタンを押した値を読み込む
                                let starCount170to99 = defaults.float(forKey: "countStar170to99")
                                // levelBarの値を増やす
                                levelBarSkill1.setProgress(levelBarSkill1.progress + starCount170to99, animated: true)
                                // levelBarの値を保存
                                defaults.set(levelBarSkill1.progress, forKey: "levelBar1Set")
                            } else if levelBarSkill1.progress >= 0.89 {
                                // 星ボタンを押した値を読み込む
                                let starCount170to99 = defaults.float(forKey: "countStar170to99")
                                levelBarSkill1.setProgress(levelBarSkill1.progress + starCount170to99, animated: true)
                                numSkill1 = numSkill1 + 1
                                levelSkill1.text = String(numSkill1)
                                levelBarSkill1.progress = 0.0
                                
                                // レベル数を保存
                                //                        defaults.set(levelAll.text, forKey: "numCount")
                                defaults.set(num, forKey: "numCount1")
                                // levelBarの値を保存
                                defaults.set(levelBarSkill1.progress, forKey: "levelBar1Set")
                            }
                        }
                        
                        numTimes1 = 0
                        defaults.set(numTimes1, forKey: "numberTimes1")
            
                        
                    // skill2のlevelBarを上げる
                    } else if cell.textLabel?.text == defaults.object(forKey: "skill2Text") as? String {
                        
                        
                        if numSkill2 >= 0 && numSkill2 <= 10 {
                            
                            numTimes2 = defaults.integer(forKey: "numberTimes2")
                            
                            // levelBarの値が0.0〜0.89の間の場合
                            if levelBarSkill2.progress >= 0.0 && levelBarSkill2.progress < 0.89 {
                                
                                let starCount20to10 = defaults.float(forKey: "countStar2")
                                levelBarSkill2.setProgress(levelBarSkill2.progress + (starCount20to10 * Float(numTimes2)), animated: true)
                                // levelBarの値を保存
                                defaults.set(levelBarSkill2.progress, forKey: "levelBar2Set")
                            } else if levelBarSkill2.progress >= 0.89 {
                                
                                let starCount20to10 = defaults.float(forKey: "countStar2")
                                levelBarSkill2.setProgress(levelBarSkill2.progress + starCount20to10, animated: true)
                                numSkill2 = numSkill2 + 1
                                levelSkill2.text = String(numSkill2)
                                levelBarSkill2.progress = 0.0
                                
                                // レベル数を保存
                                defaults.set(numSkill2, forKey: "numCount2")
                                // levelBarの値を保存
                                defaults.set(levelBarSkill2.progress, forKey: "levelBar2Set")
                                
                            }
                        } else if numSkill2 > 10 && numSkill2 <= 30 {
                                // levelBarの値が0.0〜0.89の間の場合
                                if levelBarSkill2.progress >= 0.0 && levelBarSkill2.progress < 0.89 {
                                    
                                    let starCount210to30 = defaults.float(forKey: "countStar210to30")
                                    levelBarSkill2.setProgress(levelBarSkill2.progress + starCount210to30, animated: true)
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill2.progress, forKey: "levelBar2Set")
                                } else if levelBarSkill2.progress >= 0.89 {
                                    
                                    let starCount210to30 = defaults.float(forKey: "countStar210to30")
                                    levelBarSkill2.setProgress(levelBarSkill2.progress + starCount210to30, animated: true)
                                    numSkill2 = numSkill2 + 1
                                    levelSkill2.text = String(numSkill2)
                                    levelBarSkill2.progress = 0.0
                                    
                                    // レベル数を保存
                                    defaults.set(numSkill2, forKey: "numCount2")
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill2.progress, forKey: "levelBar2Set")
                                }
                            } else if numSkill2 > 30 && numSkill2 <= 50 {
                                // levelBarの値が0.0〜0.89の間の場合
                                if levelBarSkill2.progress >= 0.0 && levelBarSkill2.progress < 0.89 {
                                    
                                    let starCount230to50 = defaults.float(forKey: "countStar230to50")
                                    levelBarSkill2.setProgress(levelBarSkill2.progress + starCount230to50, animated: true)
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill2.progress, forKey: "levelBar2Set")
                                } else if levelBarSkill2.progress >= 0.89 {
                                    
                                    let starCount230to50 = defaults.float(forKey: "countStar230to50")
                                    levelBarSkill2.setProgress(levelBarSkill2.progress + starCount230to50, animated: true)
                                    numSkill2 = numSkill2 + 1
                                    levelSkill2.text = String(numSkill2)
                                    levelBarSkill2.progress = 0.0
                                    
                                    // レベル数を保存
                                    defaults.set(numSkill2, forKey: "numCount2")
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill2.progress, forKey: "levelBar2Set")
                                }
                            } else if numSkill2 > 50 && numSkill2 <= 70 {
                                // levelBarの値が0.0〜0.89の間の場合
                                if levelBarSkill2.progress >= 0.0 && levelBarSkill2.progress < 0.89 {
                                    
                                    let starCount250to70 = defaults.float(forKey: "countStar250to70")
                                    levelBarSkill2.setProgress(levelBarSkill2.progress + starCount250to70, animated: true)
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill2.progress, forKey: "levelBar2Set")
                                } else if levelBarSkill2.progress >= 0.89 {
                                    
                                    let starCount250to70 = defaults.float(forKey: "countStar250to70")
                                    levelBarSkill2.setProgress(levelBarSkill2.progress + starCount250to70, animated: true)
                                    numSkill2 = numSkill2 + 1
                                    levelSkill2.text = String(numSkill2)
                                    levelBarSkill2.progress = 0.0
                                    
                                    // レベル数を保存
                                    defaults.set(numSkill2, forKey: "numCount2")
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill2.progress, forKey: "levelBar2Set")
                                }
                            } else if numSkill2 > 70 && numSkill2 <= 99 {
                                // levelBarの値が0.0〜0.89の間の場合
                                if levelBarSkill2.progress >= 0.0 && levelBarSkill2.progress < 0.89 {
                                    
                                    let starCount270to99 = defaults.float(forKey: "countStar270to99")
                                    levelBarSkill2.setProgress(levelBarSkill2.progress + starCount270to99, animated: true)
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill2.progress, forKey: "levelBar2Set")
                                } else if levelBarSkill2.progress >= 0.89 {
                                    
                                    let starCount270to99 = defaults.float(forKey: "countStar270to99")
                                    levelBarSkill2.setProgress(levelBarSkill2.progress + starCount270to99, animated: true)
                                    numSkill2 = numSkill2 + 1
                                    levelSkill2.text = String(numSkill2)
                                    levelBarSkill2.progress = 0.0
                                    
                                    // レベル数を保存
                                    defaults.set(numSkill2, forKey: "numCount2")
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill2.progress, forKey: "levelBar2Set")
                                }
                            }
                        
                    // skill3のlevelBarを上げる
                    } else if cell.textLabel?.text == defaults.object(forKey: "skill3Text") as? String {
                        
                        
                            if numSkill3 >= 0 && numSkill3 <= 10 {
                                // levelBarの値が0.0〜0.89の間の場合
                                if levelBarSkill3.progress >= 0.0 && levelBarSkill3.progress < 0.89 {
                                    
                                    let starCount30to10 = defaults.float(forKey: "countStar3")
                                    levelBarSkill3.setProgress(levelBarSkill3.progress + starCount30to10, animated: true)
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill3.progress, forKey: "levelBar3Set")
                                } else if levelBarSkill3.progress >= 0.89 {
                                    
                                    let starCount30to10 = defaults.float(forKey: "countStar3")
                                    levelBarSkill3.setProgress(levelBarSkill3.progress + starCount30to10, animated: true)
                                    numSkill3 = numSkill3 + 1
                                    levelSkill3.text = String(numSkill3)
                                    levelBarSkill3.progress = 0.0
                                    
                                    // レベル数を保存
                                    defaults.set(numSkill3, forKey: "numCount3")
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill3.progress, forKey: "levelBar3Set")
                                    
                                }
                            } else if numSkill3 > 10 && numSkill3 <= 30 {
                                // levelBarの値が0.0〜0.89の間の場合
                                if levelBarSkill3.progress >= 0.0 && levelBarSkill3.progress < 0.89 {
                                    
                                    let starCount310to30 = defaults.float(forKey: "countStar310to30")
                                    levelBarSkill3.setProgress(levelBarSkill3.progress + starCount310to30, animated: true)
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill3.progress, forKey: "levelBar3Set")
                                } else if levelBarSkill3.progress >= 0.89 {
                                    
                                    let starCount310to30 = defaults.float(forKey: "countStar310to30")
                                    levelBarSkill3.setProgress(levelBarSkill3.progress + starCount310to30, animated: true)
                                    numSkill3 = numSkill3 + 1
                                    levelSkill3.text = String(numSkill3)
                                    levelBarSkill3.progress = 0.0
                                    
                                    // レベル数を保存
                                    defaults.set(numSkill3, forKey: "numCount3")
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill3.progress, forKey: "levelBar3Set")
                                    
                                }
                            } else if numSkill3 > 30 && numSkill3 <= 50 {
                                // levelBarの値が0.0〜0.89の間の場合
                                if levelBarSkill3.progress >= 0.0 && levelBarSkill3.progress < 0.89 {
                                    
                                    let starCount330to50 = defaults.float(forKey: "countStar330to50")
                                    levelBarSkill3.setProgress(levelBarSkill3.progress + starCount330to50, animated: true)
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill3.progress, forKey: "levelBar3Set")
                                } else if levelBarSkill3.progress >= 0.89 {
                                    
                                    let starCount330to50 = defaults.float(forKey: "countStar330to50")
                                    levelBarSkill3.setProgress(levelBarSkill3.progress + starCount330to50, animated: true)
                                    numSkill3 = numSkill3 + 1
                                    levelSkill3.text = String(numSkill3)
                                    levelBarSkill3.progress = 0.0
                                    
                                    // レベル数を保存
                                    defaults.set(numSkill3, forKey: "numCount3")
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill3.progress, forKey: "levelBar3Set")
                                    
                                }
                            } else if numSkill3 > 50 && numSkill3 <= 70 {
                                // levelBarの値が0.0〜0.89の間の場合
                                if levelBarSkill3.progress >= 0.0 && levelBarSkill3.progress < 0.89 {
                                    
                                    let starCount350to70 = defaults.float(forKey: "countStar350to70")
                                    levelBarSkill3.setProgress(levelBarSkill3.progress + starCount350to70, animated: true)
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill3.progress, forKey: "levelBar3Set")
                                } else if levelBarSkill3.progress >= 0.89 {
                                    
                                    let starCount350to70 = defaults.float(forKey: "countStar350to70")
                                    levelBarSkill3.setProgress(levelBarSkill3.progress + starCount350to70, animated: true)
                                    numSkill3 = numSkill3 + 1
                                    levelSkill3.text = String(numSkill3)
                                    levelBarSkill3.progress = 0.0
                                    
                                    // レベル数を保存
                                    defaults.set(numSkill3, forKey: "numCount3")
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill3.progress, forKey: "levelBar3Set")
                                    
                                }
                            } else if numSkill3 > 70 && numSkill3 <= 99 {
                                // levelBarの値が0.0〜0.89の間の場合
                                if levelBarSkill3.progress >= 0.0 && levelBarSkill3.progress < 0.89 {
                                    
                                    let starCount370to99 = defaults.float(forKey: "countStar370to99")
                                    levelBarSkill3.setProgress(levelBarSkill3.progress + starCount370to99, animated: true)
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill3.progress, forKey: "levelBar3Set")
                                } else if levelBarSkill3.progress >= 0.89 {
                                    
                                    let starCount370to99 = defaults.float(forKey: "countStar370to99")
                                    levelBarSkill3.setProgress(levelBarSkill3.progress + starCount370to99, animated: true)
                                    numSkill3 = numSkill3 + 1
                                    levelSkill3.text = String(numSkill3)
                                    levelBarSkill3.progress = 0.0
                                    
                                    // レベル数を保存
                                    defaults.set(numSkill3, forKey: "numCount3")
                                    // levelBarの値を保存
                                    defaults.set(levelBarSkill3.progress, forKey: "levelBar3Set")
                                    
                                }
                            }
                 
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
    


