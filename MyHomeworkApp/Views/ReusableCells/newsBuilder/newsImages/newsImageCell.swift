//
//  newsImageCell.swift
//  MyHomeworkApp
//
//  Created by Tim on 31.01.2022.
//

import UIKit

class newsImageCell: UICollectionViewCell,UIGestureRecognizerDelegate {

    @IBOutlet var newsImage: UIImageView?
    @IBOutlet var videoPlayButton: UIImageView!
    var newAspectRatio = NSLayoutConstraint()
    
    func configure(image: UIImage?, video: Bool, aspectRatio: CGFloat = 1) {
        newsImage?.frame.size.width = UIScreen.main.bounds.width
        if aspectRatio == 1 {
            newsImage?.frame.size.height = UIScreen.main.bounds.width
        } else {
            newsImage?.frame.size.height = UIScreen.main.bounds.width * aspectRatio
        }
        self.videoPlayButton.isHidden = video
        self.newsImage?.image = UIImage(named: "default")
        self.newsImage?.image = image
        self.newsImage?.contentMode = .scaleAspectFill
    }
}
