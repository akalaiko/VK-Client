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
    
    func configure(image: UIImage?, video: Bool, aspectRatio: CGFloat) {
        self.videoPlayButton.isHidden = video
        self.newsImage?.image = image
        self.newsImage?.contentMode = .scaleAspectFill
    }
}
