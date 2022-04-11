//
//  FeedService.swift
//  MyHomeworkApp
//
//  Created by Tim on 06.04.2022.
//

import RealmSwift
import UIKit

final class FeedsService {
    static let instance = FeedsService()
    private init() {}
    
    let networkService = NetworkService<News>()
    var userNews = [News]()
    
    func getFeeds(completion: @escaping () -> Void) {
        networkServiceFunction { feeds in
            self.userNews = feeds
            self.userNews = self.userNews.filter({$0.attachment != nil})
            completion()
        }
    }
    func networkServiceFunction(completion: @escaping ([News]) -> Void){
        networkService.fetch(type: .feed) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let myNews):
                let feeds = myNews.map { feed -> News in
                return News(
                    sourceID: feed.sourceID,
                    date: feed.date,
                    text: feed.text ?? "",
                    attachment: feed.attachment,
                    likes: feed.likes,
                    reposts: feed.reposts,
                    comments: feed.comments)
                }
                completion(feeds)
            }
        }
    }

    func loadGroupByID(_ id: Int) -> Group? {
        do {
            let realmGroups: [GroupRealm] = try RealmService.load(type: GroupRealm.self)
        guard let group = realmGroups.filter({ $0.id == -id }).first  else { return nil }
                return Group(id: group.id, name: group.name, avatar: group.avatar)
        } catch {
            print(error)
            return nil
        }
    }

    func loadUserByID(_ id: Int) -> User? {
        do {
            let realmGroups: [UserRealm] = try RealmService.load(type: UserRealm.self)
        guard let user = realmGroups.filter({ $0.id == id }).first  else { return nil }
            return User(id: user.id, firstName: user.firstName, lastName: user.lastName, photo: user.photo, photoBig: user.photoBig, sex: user.sex)
        } catch {
            print(error)
            return nil
        }
    }
    
    func getSource(_ id: Int) -> (String, String)? {
        if id < 0 {
            guard let source = loadGroupByID(id) else { return nil}
            return (source.avatar, source.name)
        } else {
            guard let source = loadUserByID(id) else { return nil }
            return (source.photo, name: source.fullName)
        }
    }
}
