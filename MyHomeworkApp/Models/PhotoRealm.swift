//
//  PhotoRealm.swift
//  MyHomeworkApp
//
//  Created by Tim on 14.03.2022.
//

import Foundation
import RealmSwift

class PhotoRealm: Object {
    @Persisted(indexed: true) var ownerID: Int = Int()
    @Persisted(primaryKey: true) var url: String = ""
}

extension PhotoRealm {
    convenience init(ownerID: Int, photo: Albums) {
        self.init()
        self.ownerID = ownerID
        self.url = photo.sizes.last!.url
    }
}
