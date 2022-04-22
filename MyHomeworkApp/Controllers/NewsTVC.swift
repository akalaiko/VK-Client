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
        case top, text, image, bottom }
    var height = CGFloat()
    private let feedService = FeedsService.instance
    var userNews = [News]() {
        didSet {
            for index in userNews.indices {
                let indexPath: IndexPath = [index,1]
                textCellState[indexPath] = true
            }
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    static var nextFrom: String?
    var isLoading = false
    var textCellState = [IndexPath : Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        
        tableView.register(newsTop.self)
        tableView.register(newsText.self)
        tableView.register(newsImagesCollection.self)
        tableView.register(newsBottom.self)
        
        setupRefreshControl()
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.feedService.getFeeds { self.userNews = self.feedService.userNews }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int { userNews.count }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { Identifier.bottom.rawValue }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = userNews[indexPath.section]
        
        switch indexPath.row {
        case Identifier.top.rawValue:
            let cell: newsTop = tableView.dequeueReusableCell(for: indexPath)
            guard let source = feedService.getSource(news.sourceID) else { return cell }
            cell.selectionStyle = .none
            cell.configure(
                url: source.0,
                name: source.1,
                newsTime: Date(timeIntervalSince1970: news.date).toString(dateFormat: .dateTime))
            return cell
            
        case Identifier.text.rawValue:
            let cell: newsText = tableView.dequeueReusableCell(for: indexPath)
            guard let state = textCellState[indexPath] else { return cell}
            cell.configure(text: news.text ?? "", indexPath: indexPath, isTruncated: state)
            cell.isHidden = news.text == ""
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
            
        case Identifier.image.rawValue:
            let cell: newsImagesCollection = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(currentNews: news, indexPath: indexPath)
            cell.delegate = self
            return cell
            
        case Identifier.bottom.rawValue:
            let cell: newsBottom = tableView.dequeueReusableCell(for: indexPath)
            cell.selectionStyle = .none
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
        if indexPath.row == Identifier.text.rawValue {
            if userNews[indexPath.section].text == "" { return 0 }
        }
        if indexPath.row == Identifier.image.rawValue {
            guard let height = newsImagesCollection.collectionHeight[indexPath] else { return UITableView.automaticDimension}
            return height
        }
        return UITableView.automaticDimension
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

extension NewsTVC: ExpandableLabelDelegate {
    func didTouchText(at indexPath: IndexPath) {
        guard let state = textCellState[indexPath] else { return }
        textCellState[indexPath] = !state
        tableView.reloadRows(at: [indexPath], with: .fade)
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
