//
//  LicenceViewController.swift
//  LevelApp
//
//  Created by 門屋　陽二郎 on 2018/08/12.
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit

class LicenceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var licenceTableView: UITableView!
    
    var url = NSURL(string: "http://icons8.com/")
    let licenceArray = ["このアプリのアイコンはこちらのサイトの素材を使用しています。", "icons8.com()", "flaticon(http://www.flaticon.com/)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        //セルの高さを自動で計算
//        self.licenceTableView.estimatedRowHeight = 78
//        licenceTableView.rowHeight = UITableViewAutomaticDimension

        licenceTableView.delegate = self
        licenceTableView.dataSource  = self
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
        cell.textLabel?.text = "\(licenceArray[indexPath.row])"
        
        // セルの内容表示
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath)as! TodoListTableViewCell
        //        let todo = self.dayTodos[indexPath.row]
        //        cell.labelCell.text = todo.title
        //        cell.detailCell.text = todo.descript
        //        cell.labelCell!.font = UIFont(name: "HirakakuProN-W6", size: 15)
        return cell
        
    }
    


}
