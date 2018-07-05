//
//  NewProfileViewController.swift
//  LevelApp
//
//  Created by 門屋　陽二郎 on 2018/07/02.
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit

class NewProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var skill1Field: UITextField!
    @IBOutlet weak var skill2Field: UITextField!
    @IBOutlet weak var skill3Field: UITextField!
    @IBOutlet weak var selectImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // タップしたらキーボードが消える
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewProfileViewController.tapGesture(_:)))
        self.view.addGestureRecognizer(tapRecognizer)
        // デリゲートを設定
        nameField.delegate = self
        skill1Field.delegate = self
        skill2Field.delegate = self
        skill3Field.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 閉じるボタン、完了ボタンを作成
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NewProfileViewController.close))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完了", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NewProfileViewController.save))
        
        // userDefaultsの読み込み
        let defaults = UserDefaults.standard
        nameField.text = defaults.object(forKey: "nameText") as? String
        skill1Field.text = defaults.object(forKey: "skill1Text") as? String
        skill2Field.text = defaults.object(forKey: "skill2Text") as? String
        skill3Field.text = defaults.object(forKey: "skill3Text") as? String
        // imageViewのuserDefaultsはNSデータ型にしてから読み込み
        let imageData:NSData = UserDefaults.standard.object(forKey: "selectImage") as! NSData
        selectImageView.image = UIImage(data: imageData as Data)
    }
    
    // 閉じるボタンが押された時の処理
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 完了ボタンが押された時の処理
    @objc func save() {
        
        if nameField.text!.isEmpty {
            let alertView = UIAlertController(title: "エラー", message: "記述されていません", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "はい", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        } else {
 
            let profile = Profile()
            profile.name = nameField.text!
            profile.skill1 = skill1Field.text!
            profile.skill2 = skill2Field.text!
            profile.skill3 = skill3Field.text!
            self.dismiss(animated: true, completion: nil)
            
            // userDefaulsの保存
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
    
    // デリゲートメソッドを利用
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        // キーボードを閉じる
        nameField.resignFirstResponder()
        skill1Field.resignFirstResponder()
        skill2Field.resignFirstResponder()
        skill3Field.resignFirstResponder()
        return true
    }
    
    
    @IBAction func tapAlbumButton(_ sender: UIButton) {
        let album = UIImagePickerController()
        album.sourceType = UIImagePickerControllerSourceType.photoLibrary
        album.allowsEditing = true
        album.delegate = self
        self.present(album, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]){
        selectImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
