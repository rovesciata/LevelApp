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
        let imageData:NSData = UserDefaults.standard.object(forKey: "selectImage") as! NSData
        profileImage.image = UIImage(data: imageData as Data)
    }
    
    
    // 編集ボタンを押された時の処理
    @objc func newProfile() {
        self.performSegue(withIdentifier: "PresentNewProfileViewController", sender: self)
    }
    
    
    
        
        
        
        
    }
    


