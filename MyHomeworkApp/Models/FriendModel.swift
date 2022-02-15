//
//  FriendModel.swift
//  MyHomeworkApp
//
//  Created by Tim on 21.12.2021.
//

import Foundation
import UIKit

struct FriendModel {
    
    let name: String
    let age: UInt8
    let gender: genderType
    let avatar: UIImage?
    let id: Int
    
    enum genderType: String {
        case male = "male"
        case female = "female"
        case nonbinary = "non-binary"
    }
    
    init (name: String, age: UInt8, gender: genderType, avatar: UIImage?, id: Int) {
        self.name = name
        self.age = age
        self.gender = gender
        self.avatar = avatar ?? UIImage(named: "default")
        self.id = id
    }
}

extension FriendModel: Comparable {
    static func < (lhs: FriendModel, rhs: FriendModel) -> Bool { lhs.name < rhs.name }
}

struct ImageStruct {
    var image: UIImage
    var isLiked: Bool
    var likesCounter: Int
}

var friendDatabase = [
    FriendModel(name: "Ivanova Ivanna", age: 24, gender: .female, avatar: UIImage(named: "1"), id: 1),
    FriendModel(name: "Petrov Petr", age: 26, gender: .male, avatar: UIImage(named: "2"), id: 2),
    FriendModel(name: "Popova Nastya", age: 32, gender: .female, avatar: nil, id: 3),
    FriendModel(name: "Ishchenko Oleg", age: 45, gender: .male, avatar: UIImage(named: "4"), id: 4),
    FriendModel(name: "Prohorov Nikita", age: 18, gender: .male, avatar: UIImage(named: "5"), id: 5),
    FriendModel(name: "Nazarova Anna", age: 21, gender: .female, avatar: UIImage(named: "3"), id: 6),
    FriendModel(name: "Fillipov Andrew", age: 43, gender: .male, avatar: UIImage(named: "7"), id: 7),
    FriendModel(name: "Ovechkina Nastya", age: 23, gender: .female, avatar: nil, id: 8),
    FriendModel(name: "Venediktova Aleksandra", age: 45, gender: .female, avatar: UIImage(named: "6"), id: 9),
    FriendModel(name: "Vasiliev Anton", age: 28, gender: .male, avatar: UIImage(named: "9"), id: 10),
    FriendModel(name: "Kotova Inna", age: 34, gender: .female, avatar: UIImage(named: "10"), id: 11),
    FriendModel(name: "Artemenko Kristina", age: 16, gender: .female, avatar: UIImage(named: "8"), id: 12),
    FriendModel(name: "Zinchenko Anastasiya", age: 32, gender: .female, avatar: nil, id: 13),
    FriendModel(name: "Gavrilenko Timofei", age: 45, gender: .male, avatar: UIImage(named: "12"), id: 14),
    FriendModel(name: "Fishchenko Olga", age: 38, gender: .female, avatar: UIImage(named: "11"), id: 15)
]

var photoDatabase: [Int: [ImageStruct]] = [
    
    1: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)
       ],
    
    2: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)       ],
    
    3: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)
       ],
    
    4: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)
       ],
    
    5: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)
        ],
    
    6: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)
       ],
    
    7: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)
       ],
    
    8: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)
       ],
    
    9: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
        ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)
       ],
    
    10: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)
       ],
    
    11: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)
       ],
    
    12: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)
       ],
    
    13: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)
       ],
    
    14: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)
        ],
    
    15: [ImageStruct(image: UIImage(named: "dog1")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog5")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog6")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog7")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog8")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog9")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog2")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog3")!, isLiked: false, likesCounter: 0),
         ImageStruct(image: UIImage(named: "dog4")!, isLiked: false, likesCounter: 0)
       ]
    ]


