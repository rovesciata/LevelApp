//
//  SkillSelection.swift
//  LevelApp
//
//  Created by 門屋　陽二郎 on 2018/07/08.
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit

class SkillSelection: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!
    
    // userDefaultsの読み込み
    let defaults = UserDefaults.standard
//    skill1.text = defaults.object(forKey: "skill1Text") as? String
//    skill2.text = defaults.object(forKey: "skill2Text") as? String
//    skill3.text = defaults.object(forKey: "skill3Text") as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // myTableViewのデリゲート
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    // 行数の指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        cell.textLabel?.text = defaults.object(forKey: "skill\(indexPath.row + 1)Text") as? String
        return cell
    }
    
    // セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    // セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "タスク選択"
    }
    
    // セクションタイトルの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // セルを選択
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(defaults.object(forKey: "skill\(indexPath.row + 1)Text") as? String, forKey: "text1")
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
