//
//  GroupsService.swift
//  MyHomeworkApp
//
//  Created by Tim on 09.04.2022.
//

import Foundation
import RealmSwift

final class GroupsService {
    
    static let instance = GroupsService()
    private init() {}
    var groups = [GroupRealm]()
    
    func getGroups(completion: @escaping ([GroupRealm]) -> Void) {
        let fetchDataQueue: OperationQueue = {
            let queue = OperationQueue()
            queue.qualityOfService = .utility
            return queue
        }()
        
        let fetchData = FetchDataOperation()
        let realmSave = RealmSaveOperation()
        let realmLoad = RealmLoadOperation()
        
        realmSave.addDependency(fetchData)
        realmLoad.addDependency(realmSave)
        realmLoad.completionBlock = { completion(realmLoad.groups) }
        
        fetchDataQueue.addOperation(fetchData)
        fetchDataQueue.addOperation(realmSave)
        fetchDataQueue.addOperation(realmLoad)
    }
}
