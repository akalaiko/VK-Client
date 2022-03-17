//
//  PhotoRealm.swift
//  MyHomeworkApp
//
//  Created by Tim on 14.03.2022.
//

import Foundation
import RealmSwift

class PhotoRealm: Object {
    @Persisted(primaryKey: true) var url: String = ""
    @Persisted var height: Int = 0
}

extension PhotoRealm {
    convenience init (photo: Photo) {
        self.init()
        self.url = photo.url
        self.height = photo.height
    }
}
