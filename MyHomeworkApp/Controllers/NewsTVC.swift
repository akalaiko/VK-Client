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
    static var nextFrom: String?
    var isLoading = false
    
    var aspectRatio = CGFloat()
    var photoURLs = [String]()
    var images = [Photo?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        
        setupRefreshControl()
        
        tableView.register(newsTop.self)
        tableView.register(newsText.self)
        tableView.register(newsImagesCollection.self)
        tableView.register(newsBottom.self)
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.feedService.getFeeds { self.userNews = self.feedService.userNews }
        }
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
            cell.selectionStyle = .none
            
            return cell
            
        case Identifier.image.rawValue:
            let cell: newsImagesCollection = tableView.dequeueReusableCell(for: indexPath)
            setupVariables(news)
            cell.configure(currentNews: news, photoURLs: photoURLs, aspectRatio: aspectRatio)
            cell.delegate = self
            return cell
            
        case Identifier.bottom.rawValue:
            let cell: newsBottom = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(
                isLiked: false,
                likesCounter: news.likes?.count ?? 0,
                commentCounter: news.comments?.count ?? 0,
                shareCounter: news.reposts?.count ?? 0)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    fileprivate func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }

    @objc func refreshNews() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.feedService.getFeeds { self.userNews = self.feedService.userNews }
        }
            self.tableView.refreshControl?.endRefreshing()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = UIScreen.main.bounds.width
        if indexPath.row == Identifier.image.rawValue {
            switch photoURLs.count {
                case 1:
                    return width * aspectRatio
                case 2:
                    return width / 2
                case 3:
                    return width / 3
                case 5,6:
                    return width * 2 / 3
                case 4,7,8,9:
                    return width
                default:
                    return width
                }
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func setupVariables( _ currentNews: News) {
        aspectRatio = CGFloat()
        photoURLs.removeAll()
        images.removeAll()
        
        currentNews.attachment?.forEach { attachment in
            if attachment.link != nil { images.append(attachment.link?.photo?.sizes.last) }
            if attachment.photo != nil { images.append(attachment.photo?.sizes.last) }
            if attachment.video != nil { images.append(attachment.video?.image.last) }
        }
        
        for index in images.indices where index < 9 {
            guard let image = images[index] else { return }
            photoURLs.append(image.url)
        }
        
        if let aspectRatio = images[0]?.aspectRatio {
            self.aspectRatio = aspectRatio
        }
    }
}

extension NewsTVC: ImageCellDelegate {
    func didSelectImage(photos: [String], currentIndex: Int) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "showPhoto") as? LargePhoto {
            vc.photos = photos
            vc.chosenPhotoIndex = currentIndex
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension NewsTVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        if maxSection > self.userNews.count - 5, !isLoading {
            isLoading = true
            DispatchQueue.global(qos: .background).async {
                self.feedService.getFeeds(nextFrom: NewsTVC.nextFrom) {
                    self.userNews += self.feedService.userNews
                    self.isLoading = false
                }
            }
        }
    }
}
