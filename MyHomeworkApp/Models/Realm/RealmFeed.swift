//
//  PhotoRealm.swift
//  MyHomeworkApp
//
//  Created by Tim on 14.03.2022.
//

import Foundation
import RealmSwift

final class RealmFeed: Object {
    @Persisted(primaryKey: true) var id = ""
    @Persisted var sourceID: Int?
    @Persisted var date = Date()
    @Persisted var text = ""
//    @Persisted var photoURLs: List<String?>
    @Persisted var commentCount = 0
    @Persisted var likeCount = 0
    @Persisted var repostsCount = 0
}

extension RealmFeed {
    convenience init(sourceID: Int, date: Date, text: String, commentsCount: Int, repostsCount: Int)  {
//        photoURLs: [PhotoAttachment]?
        self.init()
        self.id = String(sourceID) + "_" + date.toString(dateFormat: .dateTime)
        self.sourceID = sourceID
        self.date = date
        self.text = text
        self.commentCount = commentsCount
        self.likeCount = 0
        self.repostsCount = repostsCount
//        self.photoURLs.append(objectsIn: p)
    }
}
