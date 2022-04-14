//
//  LoadRealmData.swift
//  MyHomeworkApp
//
//  Created by Tim on 06.04.2022.
//

import Foundation
import RealmSwift

final class RealmLoadOperation: AsyncOperation {
    var groups = [GroupRealm]()
    
    override func main(){
        guard let realmData = dependencies.first as? RealmSaveOperation?,
        realmData?.fetchedData != nil else {
            print("## Error. can't check dependencies")
            return
        }
        DispatchQueue.main.async {
            do {
                self.groups = try RealmService.load(type: GroupRealm.self)
                self.state = .finished
            } catch {
                print("## Error. can't load groups from Realm at \(#function): ", error)
            }
        }
    }
}
