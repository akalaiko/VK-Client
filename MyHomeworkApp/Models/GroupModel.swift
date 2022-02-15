//
//  GroupModel.swift
//  MyHomeworkApp
//
//  Created by Tim on 21.12.2021.
//

import Foundation
import UIKit

struct GroupModel: Equatable {
    
    let name: String
    var avatar: UIImage?

    init (name: String, avatar: UIImage?){
        self.name = name
        self.avatar = avatar ?? UIImage(named: "default")
    }
    
    static func ==(lhs: GroupModel, rhs: GroupModel) -> Bool {
        return lhs.name == rhs.name
    }
}

var userGroups: [GroupModel] = [
    GroupModel(name: "Apple Fanboys", avatar: UIImage(named: "apple")),
    GroupModel(name: "Ноготочки ЕКБ", avatar: UIImage(named: "women")),
    GroupModel(name: "Официальное сообщество плоскоземельщиков", avatar: UIImage(named: "emc2")),
    GroupModel(name: "С детства за Ньюкасл", avatar: UIImage(named: "cup"))
]

var availableGroups: [GroupModel] = [
    GroupModel(name: "Книжный клуб", avatar: UIImage(named: "book")),
    GroupModel(name: "Детективы Новосибирска", avatar: nil)
]
