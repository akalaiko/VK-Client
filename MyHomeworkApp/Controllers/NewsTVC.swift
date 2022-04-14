//
//  NewsTVC.swift
//  MyHomeworkApp
//
//  Created by Tim on 20.01.2022.
//

import UIKit
import RealmSwift

class NewsTVC: UITableViewController, UICollectionViewDelegate {

    enum Identifier: Int {
        case top, text, image, bottom
    }
    var indexOfCell: Identifier?
    private let feedService = FeedsService.instance
    var userNews = [News]() {
        didSet {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionHeaderTopPadding = 0
    
        tableView.register(newsTop.self)
        tableView.register(newsText.self)
        tableView.register(newsImagesCollection.self)
        tableView.register(newsBottom.self)
        
        feedService.getFeeds { self.userNews = self.feedService.userNews }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { userNews.count }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 4 }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = userNews[indexPath.section]
        
        switch indexPath.row {
        case Identifier.top.rawValue:
            let cell: newsTop = tableView.dequeueReusableCell(for: indexPath)
            guard let source = feedService.getSource(news.sourceID) else { return cell }
                cell.configure(
                    url: source.0,
                    name: source.1,
                    newsTime: Date(timeIntervalSince1970: news.date).toString(dateFormat: .dateTime))
            return cell
            
        case Identifier.text.rawValue:
            let cell: newsText = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(text: news.text ?? "")
            cell.isHidden = news.text == ""
            return cell
            
        case Identifier.image.rawValue:
            let cell: newsImagesCollection = tableView.dequeueReusableCell(for: indexPath)
            cell.currentNews = news
            return cell
            
        case Identifier.bottom.rawValue:
            let cell: newsBottom = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(
                isLiked: false,
                likesCounter: news.likes.count,
                commentCounter: news.comments.count,
                shareCounter: news.reposts.count)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
