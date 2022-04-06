//
//  newsImageCell.swift
//  MyHomeworkApp
//
//  Created by Tim on 31.01.2022.
//

import UIKit

class newsImageCell: UICollectionViewCell,UIGestureRecognizerDelegate {

    @IBOutlet var newsImage: UIImageView?
    
    func configure(url: String) {
        self.newsImage?.image = UIImage(named: "default")
        self.newsImage?.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "default"))
        self.newsImage?.contentMode = .scaleAspectFit
    }
}
