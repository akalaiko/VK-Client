//
//  WebService.swift
//  MyHomeworkApp
//
//  Created by Tim on 16.02.2022.
//

import Foundation
//import Alamofire

 
final class NetworkService {
    
    lazy var mySession = URLSession(configuration: configuration)
    let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10.0
        return config
    }()
    
    private var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        return constructor
    }()
    
    
    func fetchFriends(completion: @escaping (Result<Friends, Error>) -> Void) {
        var constructor = urlConstructor
        constructor.path = "/method/friends.get"
        constructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(SingletonModel.instance.userID)"),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "sex,photo_200"),
            URLQueryItem(name: "access_token", value: "\(SingletonModel.instance.token)"),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        guard let url = constructor.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = mySession.dataTask(with: request) { (data, response, error) in
            guard
                error == nil,
                let data = data
            else { return }
            do {
                let friendsResponse = try JSONDecoder().decode(FriendsResponse.self, from: data)
                completion(.success(friendsResponse.response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchGroups(completion: @escaping (Result<Groups, Error>) -> Void) {
        var constructor = urlConstructor
        constructor.path = "/method/groups.get"
        constructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(SingletonModel.instance.userID)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: "\(SingletonModel.instance.token)"),
        ]
        guard let url = constructor.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = mySession.dataTask(with: request) { (data, response, error) in
            guard
                error == nil,
                let data = data
            else { return }
            do {
                let groupsResponse = try JSONDecoder().decode(GroupsResponse.self, from: data)
                completion(.success(groupsResponse.response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
        
    
    func fetchGroupsSearch(_ q: String, completion: @escaping (Result<Groups, Error>) -> Void) {
        var constructor = urlConstructor
        constructor.path = "/method/groups.search"
        constructor.queryItems = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "sort", value: "3"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: "\(SingletonModel.instance.token)"),
        ]
        guard let url = constructor.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = mySession.dataTask(with: request) { (data, response, error) in
            guard
                error == nil,
                let data = data
            else { return }
            do {
                let groupsResponse = try JSONDecoder().decode(GroupsResponse.self, from: data)
                completion(.success(groupsResponse.response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchPhotos(id: Int, completion: @escaping (Result<Photos,Error>) -> Void) {
        var constructor = urlConstructor
        constructor.path = "/method/photos.get"
        constructor.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(id)"),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "rev", value: "1"),
            URLQueryItem(name: "photo_sizes", value: "0"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: "\(SingletonModel.instance.token)"),
        ]
        guard let url = constructor.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let task = mySession.dataTask(with: request) { (data, response, error) in
            guard
                error == nil,
                let data = data
            else { return }
            do {
                let photosResponse = try JSONDecoder().decode(PhotosResponse.self, from: data)
                completion(.success(photosResponse.response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
//        performTask(url)
    }

//    func performTask(_ url: URL) {
//        let task = mySession.dataTask(with: url) { data, response, error in
//            if let response = response as? HTTPURLResponse {
//                print(response.statusCode)
//            }
//            guard
//                error == nil,
//                let data = data
//            else { return }
//            let json = try? JSONSerialization.jsonObject(
//                with: data,
//                options: .allowFragments)
//            print(json)
//        }
//        task.resume()
//    }
}
