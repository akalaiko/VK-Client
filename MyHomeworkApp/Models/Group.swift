//
//  Group.swift
//  MyHomeworkApp
//
//  Created by Tim on 19.02.2022.
//

import Foundation

struct Group {
    
    var name: String
    var avatar: String? = nil
    
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = avatar
    }
    
}

extension Group: Equatable {
    
    static func ==(lhs: Group, rhs: Group) -> Bool {
        return lhs.name == rhs.name
    }
}

