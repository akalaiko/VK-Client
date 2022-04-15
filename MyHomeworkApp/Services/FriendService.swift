//
//  FriendService.swift
//  MyHomeworkApp
//
//  Created by Tim on 09.04.2022.
//

import Foundation
import RealmSwift
import PromiseKit

final class FriendService {
    
    static let instance = FriendService()
    private init() {}
    
    enum AppError: Error {
        case errorTask
        case failedToDecode
        case realmInOutFail
    }
    
    lazy var mySession = URLSession.shared
    let scheme = "https"
    let host = "api.vk.com"
    private var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        constructor.path = "/method/friends.get"
        constructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(UserToken.instance.userID)"),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "sex,photo_50,photo_200"),
            URLQueryItem(name: "access_token", value: "\(UserToken.instance.token)"),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        return constructor
    }()
    
    func getFriends() -> Promise<Data> {
        return Promise { resolver in
            guard let url = urlConstructor.url else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            self.mySession.dataTask(with: request) { (data, response, error) in
                guard
                    error == nil,
                    let data = data
                else {
                    resolver.reject(AppError.errorTask)
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }
    
    func getParsedData(data: Data) -> Promise<[User]> {
        return Promise { resolver in
            do {
                let json = try JSONDecoder().decode(Response<User>.self, from: data).response.items
                resolver.fulfill(json)
            } catch {
                resolver.reject(AppError.failedToDecode)
            }
        }
    }
    
    func usersRealmInOut(users: [User]) -> Promise<[UserRealm]> {
        return Promise { resolver in
            let items = users.map { i in
                UserRealm(user: i)
            }
            DispatchQueue.main.async {
                do {
                    try RealmService.save(items: items)
                    let users = try RealmService.load(type: UserRealm.self)
                    resolver.fulfill(users)
                } catch {
                    resolver.reject(AppError.realmInOutFail)
                    print(error)
                }
            }
        }
    }
}

