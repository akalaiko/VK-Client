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
    @Persisted(indexed: true) var likes = Int()
}

extension PhotoRealm {
    convenience init(ownerID: Int, photo: Photos, likes: Int) {
        self.init()
        self.ownerID = ownerID
        self.url = photo.sizes.last!.url
        self.likes = likes
    }
}
