//
//  NewsTVC.swift
//  MyHomeworkApp
//
//  Created by Tim on 20.01.2022.
//

import UIKit

class NewsTVC: UITableViewController, UICollectionViewDelegate,UIGestureRecognizerDelegate {
    
    enum Identifier {
        case top
        case text
        case image
        case bottom
    }
    
    var indexOfCell: Identifier?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(UINib(
            nibName: "newsTop",
            bundle: nil),
            forCellReuseIdentifier: "newsTopCell")
        
        tableView.register(UINib(
            nibName: "newsText",
            bundle: nil),
            forCellReuseIdentifier: "newsTextCell")
        
        tableView.register(UINib(
            nibName: "newsImagesCollection",
            bundle: nil),
            forCellReuseIdentifier: "newsImageCell")
        
        tableView.register(UINib(
            nibName: "newsBottom",
            bundle: nil),
            forCellReuseIdentifier: "newsBottomCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsFeed.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number = 4
        if newsFeed[section].text == nil { number -= 1 }
        if newsFeed[section].images == nil { number -= 1 }
        return number
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsFeed[indexPath.section]
        
        switch indexPath.row {
        case 0:
            indexOfCell = .top
        case 1:
            indexOfCell = (news.text == nil) ? .image : .text
        case 2:
            indexOfCell = (news.images == nil) || news.text == nil ? .bottom : .image
        case 3:
            indexOfCell = .bottom
        default:
            indexOfCell = .none
        }
        
        switch indexOfCell {
        case .top:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsTopCell", for: indexPath) as? newsTop
            else { return UITableViewCell() }
            
            cell.configure(
                avatar: news.group.avatar,
                name: news.group.name,
                newsTime: news.time)
            return cell
            
        case .text:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsTextCell", for: indexPath) as? newsText
            else { return UITableViewCell() }
            cell.newsText.text = news.text
            return cell
            
        case .image:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsImageCell", for: indexPath) as? newsImagesCollection
            else { return UITableViewCell() }
            cell.currentNews = news
            
            return cell
            
        case .bottom:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsBottomCell", for: indexPath) as? newsBottom
            else { return UITableViewCell() }
            
            cell.configure(isLiked: news.isLiked!, likesCounter: news.likesCounter!, commentCounter: news.commentCounter!, shareCounter: news.shareCounter!)
            
            return cell
            
        case .none:
            return UITableViewCell()
        
        }
    }

}
