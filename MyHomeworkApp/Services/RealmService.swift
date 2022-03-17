//
//  RealmService.swift
//  MyHomeworkApp
//
//  Created by Tim on 14.03.2022.
//

import RealmSwift

final class RealmService {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    class func save<T:Object>(
        items: [T],
        configuration: Realm.Configuration = deleteIfMigration,
        update: Realm.UpdatePolicy = .modified) throws {
            let realm = try Realm(configuration: configuration)
            try realm.write {
                realm.add(items,update: update)
            }
        }
    
    class func add<T:Object> (item: T) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(item)
        }
    }
    
    class func load<T:Object> (typeOf: T.Type) throws -> Results<T> {
        let realm = try Realm()
        return realm.objects(T.self)
    }
    
    class func delete<T:Object>(object: T) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(object)
        }
    }
    
    class func delete<T:Object>(object: Results<T>) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(object)
        }
    }

    class func clear() throws {
        let realm = try Realm()
        try realm.write {
            realm.deleteAll()
        }
    }
    
}
