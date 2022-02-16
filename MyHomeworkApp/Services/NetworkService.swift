//
//  WebService.swift
//  MyHomeworkApp
//
//  Created by Tim on 16.02.2022.
//

import Foundation
import Alamofire
 
final class NetworkService {
//    let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=Múnich&appid=f2bfc9ecbd40d4867ce6e7e6de10f5e0")
//    let session = URLSession.shared
    
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
    
    
    func fetchFriends() {
        var constructor = urlConstructor
        constructor.path = "/method/friends.get"
        constructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(SingletonModel.instance.userID)"),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "bday,sex,photo_100"),
            URLQueryItem(name: "access_token", value: "\(SingletonModel.instance.token)"),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        guard let url = constructor.url else { return }
        performTask(url)
    }
    
    func fetchGroups() {
        var constructor = urlConstructor
        constructor.path = "/method/groups.get"
        constructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(SingletonModel.instance.userID)"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: "\(SingletonModel.instance.token)"),
        ]
        guard let url = constructor.url else { return }
        performTask(url)
    }
    
    func fetchGroupsSearch(_ q: String) {
        var constructor = urlConstructor
        constructor.path = "/method/groups.search"
        constructor.queryItems = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "count", value: "50"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: "\(SingletonModel.instance.token)"),
        ]
        guard let url = constructor.url else { return }
        performTask(url)
    }
    
    func fetchPhotos() {
        var constructor = urlConstructor
        constructor.path = "/method/photos.get"
        constructor.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(SingletonModel.instance.userID)"),
            URLQueryItem(name: "album_id", value: "282815920"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: "\(SingletonModel.instance.token)"),
        ]
        guard let url = constructor.url else { return }
        performTask(url)
    }

    func performTask(_ url: URL) {
        let task = mySession.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard
                error == nil,
                let data = data
            else { return }
            let json = try? JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments)
            print(json)
        }
        task.resume()
    }
}
