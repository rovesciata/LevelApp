//
//  TodoListTableViewCell.swift
//  LevelApp
//
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var detailCell: UILabel!
    @IBOutlet weak var starButton2: UIButton!
    @IBOutlet weak var redStarImage: UIImageView!
    @IBOutlet weak var spaceLabel: UILabel!
    
    let todoCollection = TodoCollection.sharedInstance
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // 詳細の長さにより高さを可変にする
        detailCell.numberOfLines = 0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func starButtonCell(_ sender: UIButton) {

    }
}
