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
    
    func configure(url: String, video: Bool) {
        self.videoPlayButton.isHidden = video
        self.newsImage?.image = UIImage(named: "default")
        self.newsImage?.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "default"))
        self.newsImage?.contentMode = .scaleAspectFit
    }
}
