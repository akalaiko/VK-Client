//
//  GroupsService.swift
//  MyHomeworkApp
//
//  Created by Tim on 09.04.2022.
//

import Foundation
import RealmSwift

final class GroupsService: AsyncOperation {
    
    static let instance = GroupsService()
    override init() {}
    private let networkService = NetworkService<Group>()

    override func main(){
        networkService.fetch(type: .groups) { result in
            switch result {
            case .success(let myGroups):
                    let items = myGroups.map { GroupRealm(group: $0) }
                DispatchQueue.main.async {
                    do {
                        try RealmService.save(items: items)
                        self.state = .finished
                    } catch {
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
