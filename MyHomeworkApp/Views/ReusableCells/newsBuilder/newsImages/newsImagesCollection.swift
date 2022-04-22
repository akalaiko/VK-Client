//
//  newsImagesCollection.swift
//  MyHomeworkApp
//
//  Created by Tim on 31.01.2022.
//

import UIKit

class newsImagesCollection: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var currentNews: News? = nil
    var delegate: ImageCellDelegate?
    private var imageService: PhotoService?
    var aspectRatio = CGFloat()
    var photoURLs = [String]()
    static var collectionHeight = [IndexPath : CGFloat]()

    func configure(currentNews: News?, indexPath: IndexPath) {
        guard let news = currentNews else { return }
        self.currentNews = news
        setupVariables(news)
        configureLayout()
        newsImagesCollection.collectionHeight[indexPath] = collectionView.frame.size.height
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        collectionView.delegate = self
        collectionView.dataSource = self
        imageService = PhotoService(container: collectionView)
        collectionView.register(newsImageCell.self)
    }

    func setupVariables( _ currentNews: News) {
        var images = [Photo?]()
        aspectRatio = 1
        photoURLs.removeAll()
        
        currentNews.attachment?.forEach { attachment in
            if attachment.link != nil { images.append(attachment.link?.photo?.sizes.last) }
            if attachment.photo != nil { images.append(attachment.photo?.sizes.last) }
            if attachment.video != nil { images.append(attachment.video?.image.last) }
        }

        for index in images.indices where index < 9 {
            if let image = images[index] { photoURLs.append(image.url) }
        }
        if let aspectRatio = images[0]?.aspectRatio {
            self.aspectRatio = images.count == 1 ? aspectRatio : 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { photoURLs.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: newsImageCell = collectionView.dequeueReusableCell(for: indexPath)
        let isVideo = currentNews?.attachment?[indexPath.row].video
        let image = imageService?.photo(atIndexPath: indexPath, byUrl: photoURLs[indexPath.row])
        cell.configure(image: image, video: isVideo == nil, aspectRatio: aspectRatio)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectImage(photos: photoURLs, currentIndex: indexPath.row)
    }
    
    func configureLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        switch photoURLs.count {
        case 1:
            collectionView.frame.size.height = width * aspectRatio
            layout.itemSize = CGSize(width: width, height: width * aspectRatio)
        case 2:
            collectionView.frame.size.height = width / 2
            layout.itemSize = CGSize(width: width / 2, height: width / 2)
        case 3:
            collectionView.frame.size.height = width / 3
            layout.itemSize = CGSize(width: width / 3, height: width / 3)
        case 4:
            collectionView.frame.size.height = width
            layout.itemSize = CGSize(width: width / 2, height: width / 2)
        case 5, 6:
            collectionView.frame.size.height = width * 2 / 3
            layout.itemSize = CGSize(width: width / 3, height: width / 3)
        case 7, 8, 9:
            collectionView.frame.size.height = width
            layout.itemSize = CGSize(width: width / 3, height: width / 3)
        default:
            break
        }
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }
}

