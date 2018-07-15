//
//  Todo.swift
//  LevelApp
//
//  Created by 門屋　陽二郎 on 2018/06/29.
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit

// skill選択の列挙型enumのプロパティを定義
//enum TodoSkill: Int {
//    case Skill1 = 0
//    case Skill2 = 1
//    case Skill3 = 2
//}

class Todo: NSObject {
    var title = ""
    var descript = ""
    var finished = false
//    var skill: TodoSkill = .Skill1
}
