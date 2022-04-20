//
//  FriendService.swift
//  MyHomeworkApp
//
//  Created by Tim on 09.04.2022.
//

import Foundation
import RealmSwift

final class FriendService: AsyncOperation {
    
    static let instance = FriendService()
    override init() {}
    private let networkService = NetworkService<User>()
    
    override func main(){
        networkService.fetch(type: .friends) { result in
            switch result {
            case .success(let responseFriends):
                    let items = responseFriends.map { UserRealm(user: $0) }
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

