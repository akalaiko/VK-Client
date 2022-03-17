//
//  GroupRealm.swift
//  MyHomeworkApp
//
//  Created by Tim on 14.03.2022.
//

import Foundation
import RealmSwift

class GroupRealm: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var avatar: String = ""
}

extension GroupRealm {
    convenience init(group: GroupData) {
        self.init()
        self.id = group.id
        self.name = group.name
        self.avatar = group.avatar
    }
}