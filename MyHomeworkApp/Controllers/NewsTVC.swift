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
    var variables: ([String], CGFloat) = ([],0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionHeaderTopPadding = 0
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
        variables = setupVariables(news)
        
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
            cell.configure(currentNews: news, photoURLs: variables.0, aspectRatio: variables.1)
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case Identifier.image.rawValue:
            let width = view.frame.width
            let numberOfAttachments = variables.0.count
            let aspectRatio = variables.1
            if numberOfAttachments == 1 {
                let cellHeight = width * aspectRatio
                print(numberOfAttachments, aspectRatio, cellHeight)
                return cellHeight
            } else {
                return UITableView.automaticDimension
            }
        default:
            return UITableView.automaticDimension
        }
    }
    
    func setupVariables( _ currentNews: News) -> ([String], CGFloat) {
            var attachments = [String]()
            var onlyFirstAspectRatio: CGFloat = 0.0
            currentNews.attachment?.forEach { i in
                if i.photo != nil {
                    guard let image = i.photo?.sizes.last else { return }
                    if attachments.isEmpty { onlyFirstAspectRatio = image.aspectRatio }
                    attachments.append(image.url)
                } else if i.video != nil {
                    guard let image = i.video?.image.last else { return }
                    if attachments.isEmpty { onlyFirstAspectRatio = image.aspectRatio }
                    attachments.append(image.url)
                } else if i.link != nil {
                    guard let image = i.link?.photo?.sizes.last else { return }
                    if attachments.isEmpty { onlyFirstAspectRatio = image.aspectRatio }
                    attachments.append(image.url)
                } else { return }
            }
        return (attachments, onlyFirstAspectRatio)
    }
    
    fileprivate func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }

    @objc func refreshNews() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.feedService.getFeeds { self.userNews = self.feedService.userNews }
        }

        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
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
        if maxSection > self.userNews.count - 3, !isLoading {
            isLoading = true
            DispatchQueue.global(qos: .userInteractive).async {
                self.feedService.getFeeds(nextFrom: NewsTVC.nextFrom) {
                    self.userNews += self.feedService.userNews
                    self.isLoading = false
                }
            }
        }
    }
}
