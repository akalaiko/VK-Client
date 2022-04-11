//
//  FriendService.swift
//  MyHomeworkApp
//
//  Created by Tim on 09.04.2022.
//

import Foundation
import RealmSwift

final class FriendService {
    
    static let instance = FriendService()
    private init() {}
    private let networkService = NetworkService<User>()
    
    func networkServiceFunction(completion: @escaping ([UserRealm]) -> Void){
        networkService.fetch(type: .friends) { result in
            switch result {
            case .success(let responseFriends):
                    let items = responseFriends.map { UserRealm(user: $0) }
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

