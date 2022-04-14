//
//  RealmSaveOperation.swift.swift
//  MyHomeworkApp
//
//  Created by Tim on 06.04.2022.
//

import Foundation
import RealmSwift

final class RealmSaveOperation: AsyncOperation {
    private(set) var fetchedData: [GroupRealm] = []
    private(set) var realmResults: Results<GroupRealm>?
    
    override init() {}
    
    override func main() {
        guard
            let fetchDataOperation = dependencies.first(where: { $0 is FetchDataOperation }) as? FetchDataOperation,
            let data = fetchDataOperation.fetchedData
        else {
            print("## Error. Data is not loaded from JSON")
            return
        }
        self.fetchedData = data.map { GroupRealm(group: $0) }
        DispatchQueue.main.async {
            do {
                try RealmService.save(items: self.fetchedData)
                self.state = .finished
            } catch {
                print("## Error. can't load groups from Realm at \(#function): ", error)
            }
        }
    }
}
