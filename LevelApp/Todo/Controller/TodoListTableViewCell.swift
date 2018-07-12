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
    @IBOutlet weak var starImageCell: UIImageView!
    
    var checked: UIImage = UIImage(named: "icons8-星-48.png")!
    // 星ボタンの縮小
    var transScale = CGAffineTransform()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func starButtonCell(_ sender: UIButton) {
        starImageCell.image = checked
        // 星ボタンの縮小処理
        transScale = CGAffineTransform(scaleX: 1, y: 1)
        starImageCell.transform = transScale
    }
}
