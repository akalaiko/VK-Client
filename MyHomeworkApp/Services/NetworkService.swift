//
//  WebService.swift
//  MyHomeworkApp
//
//  Created by Tim on 16.02.2022.
//

import Foundation

final class NetworkService<ItemsType: Decodable>  {
    
    enum requestType {
        case friends
        case groups
        case groupSearch
        case photos
        case feed
    }
    
    lazy var mySession = URLSession.shared
    let scheme = "https"
    let host = "api.vk.com"
    
    private var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        return constructor
    }()
    
    func fetch(type: requestType, q: String? = "", id: Int? = 0, nextFrom: String? = "", completion: @escaping (Result<[ItemsType], Error>) -> Void) {
        var constructor = urlConstructor
        switch type {
        case .friends:
            constructor.path = "/method/friends.get"
            constructor.queryItems = [
                URLQueryItem(name: "user_id", value: "\(UserToken.instance.userID)"),
                URLQueryItem(name: "order", value: "name"),
                URLQueryItem(name: "fields", value: "sex,photo_50,photo_200"),
                URLQueryItem(name: "access_token", value: "\(UserToken.instance.token)"),
                URLQueryItem(name: "v", value: "5.131"),
            ]
        case .groups:
            constructor.path = "/method/groups.get"
            constructor.queryItems = [
                URLQueryItem(name: "user_id", value: "\(UserToken.instance.userID)"),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "v", value: "5.131"),
                URLQueryItem(name: "access_token", value: "\(UserToken.instance.token)"),
            ]
        case .groupSearch:
            constructor.path = "/method/groups.search"
            constructor.queryItems = [
                URLQueryItem(name: "q", value: q),
                URLQueryItem(name: "count", value: "20"),
                URLQueryItem(name: "sort", value: "3"),
                URLQueryItem(name: "v", value: "5.131"),
                URLQueryItem(name: "access_token", value: "\(UserToken.instance.token)"),
            ]
        case .photos:
            constructor.path = "/method/photos.get"
            constructor.queryItems = [
                URLQueryItem(name: "owner_id", value: "\(id ?? 0)"),
                URLQueryItem(name: "album_id", value: "profile"),
                URLQueryItem(name: "rev", value: "1"),
                URLQueryItem(name: "photo_sizes", value: "0"),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "v", value: "5.131"),
                URLQueryItem(name: "access_token", value: "\(UserToken.instance.token)"),
            ]
        case .feed:
            constructor.path = "/method/newsfeed.get"
            constructor.queryItems = [
                URLQueryItem(name: "filters", value: "post, photo"),
                URLQueryItem(name: "start_from", value: nextFrom),
                URLQueryItem(name: "max_photos", value: "9"),
                URLQueryItem(name: "count", value: "50"),
                URLQueryItem(name: "source_ids", value: "friends,groups,pages"),
                URLQueryItem(name: "v", value: "5.131"),
                URLQueryItem(name: "access_token", value: "\(UserToken.instance.token)"),
            ]
        }

        guard let url = constructor.url else { return }
        
        let task = mySession.dataTask(with: url) { data, response, error in
            guard
                error == nil,
                let data = data
            else { return }
            do{
                let json = try JSONDecoder().decode(Response<ItemsType>.self, from: data)
                if type == .feed { NewsTVC.nextFrom = json.response.nextFrom ?? ""}
                completion(.success(json.response.items))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
