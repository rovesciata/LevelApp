//
//  TodoListTableViewCell.swift
//  LevelApp
//
//  Created by 門屋　陽二郎 on 2018/07/12.
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var detailCell: UILabel!
    @IBOutlet weak var starButton2: UIButton!
    
    let todoCollection = TodoCollection.sharedInstance

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func starButtonCell(_ sender: UIButton) {

    }
}
