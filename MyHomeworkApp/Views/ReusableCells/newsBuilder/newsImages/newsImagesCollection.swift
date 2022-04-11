//
//  newsImagesCollection.swift
//  MyHomeworkApp
//
//  Created by Tim on 31.01.2022.
//

import UIKit

class newsImagesCollection: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    var currentNews: News? = nil {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var photoURLs: [String] {
        var attachments = [String]()
        attachments.removeAll()
        currentNews?.attachment?.forEach { i in
            if i.photo != nil {
                guard let image = i.photo?.sizes.last?.url else { return }
                attachments.append(image)
            } else if i.video != nil {
                guard let image = i.video?.image.last?.url else { return }
                attachments.append(image)
            } else { return }
        }
        return attachments
    }
    var numberOfItems = CGFloat()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        numberOfItems = CGFloat(photoURLs.count)
        configureLayout()
     
        collectionView.register(newsImageCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: newsImageCell = collectionView.dequeueReusableCell(for: indexPath)
        let isVideo = currentNews?.attachment?[indexPath.row].video
        
        var photos = [String]()
        photos.removeAll()
        currentNews?.attachment?.forEach { i in
            if i.photo != nil {
                guard let image = i.photo?.sizes.last?.url else { return }
                photos.append(image)
            } else if i.video != nil {
                guard let image = i.video?.image.last?.url else { return }
                photos.append(image)
            }
            else {
                return
            }
        }
        
        cell.configure(url: photoURLs[indexPath.row], video: isVideo == nil)
        return cell
    }
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var aspect11: NSLayoutConstraint!
    @IBOutlet var aspect21: NSLayoutConstraint!
    @IBOutlet var aspect31: NSLayoutConstraint!
    @IBOutlet var aspect32: NSLayoutConstraint!
    
    func configureLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        aspect11.isActive = false
        aspect21.isActive = false
        aspect31.isActive = false
        aspect32.isActive = false
        

        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        switch numberOfItems {
        case 1:
            aspect11.isActive = true
            layout.itemSize = CGSize(width: width, height: width)
        case 2:
            aspect21.isActive = true
            layout.itemSize = CGSize(width: width / numberOfItems, height: width / numberOfItems)
        case 3:
            aspect31.isActive = true
            layout.itemSize = CGSize(width: width / numberOfItems, height: width / numberOfItems)
        case 4:
            aspect11.isActive = true
            layout.itemSize = CGSize(width: width / 2, height: width / 2)
        case 5, 6:
            aspect32.isActive = true
            layout.itemSize = CGSize(width: width / 3, height: width / 3)
        case 7, 8, 9:
            aspect11.isActive = true
            layout.itemSize = CGSize(width: width / 3, height: width / 3)
        default:
            break
        }
        
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }
}

