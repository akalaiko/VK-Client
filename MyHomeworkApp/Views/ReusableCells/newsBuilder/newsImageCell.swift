//
//  newsImageCell.swift
//  MyHomeworkApp
//
//  Created by Tim on 31.01.2022.
//

import UIKit

class newsImageCell: UICollectionViewCell,UIGestureRecognizerDelegate {

    @IBOutlet var newsImage: UIImageView!
    
    func configure(url: String) {
        self.newsImage.image = nil
        self.newsImage.downloaded(from: url)
        self.newsImage.contentMode = .scaleAspectFit
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImage.image = nil
    }
}
