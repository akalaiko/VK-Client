//
//  newsImagesCollection.swift
//  MyHomeworkApp
//
//  Created by Tim on 31.01.2022.
//

import UIKit

class newsImagesCollection: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var aspect11: NSLayoutConstraint!
    @IBOutlet var aspect21: NSLayoutConstraint!
    @IBOutlet var aspect31: NSLayoutConstraint!
    @IBOutlet var aspect32: NSLayoutConstraint!
    var newConstraint = NSLayoutConstraint()
    
    var currentNews: News? = nil
    var delegate: ImageCellDelegate?
    private var imageService: PhotoService?
    var aspectRatio = CGFloat()
//    {
//        if let aspectRatio = images[0]?.aspectRatio {
//            newConstraint = aspect11.constraintWithMultiplier(aspectRatio)
//            return aspectRatio
//        }
//        return 1
//    }
    var photoURLs = [String]()
    var images = [Photo?]()
    
    func configure(currentNews: News?, photoURLs: [String], aspectRatio: CGFloat) {
//    func configure(currentNews: News?) {
        guard let news = currentNews else { return }
        self.currentNews = news
        self.photoURLs = photoURLs
        self.aspectRatio = aspectRatio
        newConstraint = aspect11.constraintWithMultiplier(aspectRatio)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        collectionView.delegate = self
        collectionView.dataSource = self
        imageService = PhotoService(container: collectionView)
        collectionView.register(newsImageCell.self)

        configureLayout()
        
//        print(currentNews?.text, "images: ",images.count, "photoURLs: ",photoURLs.count, "aspectRatio: ",aspectRatio)
    }
    
    override func prepareForReuse() {
        aspectRatio = CGFloat()
        photoURLs.removeAll()
        images.removeAll()
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
        
        aspect11.isActive = false
        aspect21.isActive = false
        aspect31.isActive = false
        aspect32.isActive = false
        newConstraint.isActive = false
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        switch photoURLs.count {
        case 1:
            layout.itemSize = CGSize(width: width, height: width * aspectRatio)
            newConstraint.isActive = true
        case 2:
            aspect21.isActive = true
            layout.itemSize = CGSize(width: width / 2, height: width / 2)
        case 3:
            aspect31.isActive = true
            layout.itemSize = CGSize(width: width / 3, height: width / 3)
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

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}

