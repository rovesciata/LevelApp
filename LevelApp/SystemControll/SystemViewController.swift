//
//  SystemViewController.swift
//  LevelApp
//
//  Created by 門屋　陽二郎 on 2018/08/04.
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit

class SystemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var systemTableView: UITableView!
    
    let systemArray = ["ライセンスについて", "このアプリを評価する", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        systemTableView.delegate = self
        systemTableView.dataSource  = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-------------TableViewの処理------------------
    
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        cell.textLabel?.text = "\(systemArray[indexPath.row])"
        
        // セルの内容表示
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath)as! TodoListTableViewCell
//        let todo = self.dayTodos[indexPath.row]
//        cell.labelCell.text = todo.title
//        cell.detailCell.text = todo.descript
//        cell.labelCell!.font = UIFont(name: "HirakakuProN-W6", size: 15)
        return cell
            
        }
    
    // Cell が選択された場合
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
       
            // LicenceViewControllerへ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "toLicenceViewController",sender: nil)
        }
    
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toLicenceViewController") {
            let licVC: LicenceViewController = (segue.destination as? LicenceViewController)!
            
        }
    }
    

    

}
