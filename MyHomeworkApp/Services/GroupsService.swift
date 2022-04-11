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
    private let networkService = NetworkService<Group>()
    
    func networkServiceFunction(completion: @escaping ([GroupRealm]) -> Void){
        networkService.fetch(type: .groups) { result in
            switch result {
            case .success(let myGroups):
                    let items = myGroups.map { GroupRealm(group: $0) }
                DispatchQueue.main.async {
                    do {
                        try RealmService.save(items: items)
                    } catch {
                        print(error)
                    }
                }
                completion(items)
            case .failure(let error):
                print(error)
            }
        }
    }
}
