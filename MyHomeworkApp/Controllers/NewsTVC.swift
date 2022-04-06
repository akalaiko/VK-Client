//
//  NewsTVC.swift
//  MyHomeworkApp
//
//  Created by Tim on 20.01.2022.
//

import UIKit
import RealmSwift

class NewsTVC: UITableViewController, UICollectionViewDelegate,UIGestureRecognizerDelegate {
    
    enum Identifier {
        case top
        case text
        case image
        case bottom
    }
    private let networkService = NetworkService<News>()
    var userNews = [News]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    var indexOfCell: Identifier?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionHeaderTopPadding = 0
    
        tableView.register(newsTop.self)
        tableView.register(newsText.self)
        tableView.register(newsImagesCollection.self)
        tableView.register(newsBottom.self)
        
        networkServiceFunction()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return userNews.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number = 4
        if userNews[section].text == nil { number -= 1 }
        if userNews[section].photosURLs == nil { number -= 1 }
        return number
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = userNews[indexPath.section]
        
        switch indexPath.row {
        case 0:
            indexOfCell = .top
        case 1:
            indexOfCell = (news.text == nil) ? .image : .text
        case 2:
            indexOfCell = (news.photosURLs == nil) || news.text == nil ? .bottom : .image
        case 3:
            indexOfCell = .bottom
        default:
            indexOfCell = .none
        }
        
        switch indexOfCell {
        case .top:
            let cell: newsTop = tableView.dequeueReusableCell(for: indexPath)
            let group = loadGroupByID(news.sourceID)
            
            cell.configure(
                url: group!.avatar,
                name: group!.name,
                newsTime: Date(timeIntervalSince1970: news.date).toString(dateFormat: .dateTime))
            return cell
            
        case .text:
            let cell: newsText = tableView.dequeueReusableCell(for: indexPath)

            cell.configure(text: news.text ?? "")
            return cell
            
        case .image:
            let cell: newsImagesCollection = tableView.dequeueReusableCell(for: indexPath)
            var photos = [String]()
            news.photosURLs?.forEach({ i in
                guard let photoURL = i.photo?.sizes.last?.url else { return }
                photos.append(photoURL)
            })
            
            cell.currentNews = news
            cell.photoURLs = photos

            return cell
            
        case .bottom:
            let cell: newsBottom = tableView.dequeueReusableCell(for: indexPath)

            cell.configure(
                isLiked: false,
                likesCounter: news.likes.count,
                commentCounter: news.comments.count,
                shareCounter: news.reposts.count)

            return cell
            
        case .none:
            return UITableViewCell()
        }
    }
    
    func networkServiceFunction() {
        networkService.fetch(type: .feed) { [weak self] result in
            switch result {
            case .success(let myNews):
                DispatchQueue.main.async {
                    myNews.forEach() { i in
                        guard let attachment = i.photosURLs else { return }
                        attachment.forEach { j in
                            guard j.type == "photo" else { return }
                            let new = News(
                                sourceID: i.sourceID,
                                date: i.date,
                                text: i.text ?? "",
                                photosURLs: attachment,
                                likes: i.likes,
                                reposts: i.reposts,
                                comments: i.comments)
                            guard self?.userNews.contains(new) == false else { return }
                        self?.userNews.append(new) }
                    }
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func loadGroupByID(_ id: Int) -> Group? {
        do {
            let realmGroups: [GroupRealm] = try RealmService.load(type: GroupRealm.self)
        guard let group = realmGroups.filter({ $0.id == -id }).first  else { return nil }
                return Group(id: group.id, name: group.name, avatar: group.avatar)
        } catch {
            print(error)
            return nil
        }
    }
}
