//
//  newsText.swift
//  MyHomeworkApp
//
//  Created by Tim on 20.01.2022.
//

import UIKit

class newsText: UITableViewCell {
    
    @IBOutlet var newsText: UILabel!
    
    var indexPath = IndexPath()
    var delegate: ExpandableLabelDelegate?
    
    func configure(text: String, indexPath: IndexPath, isTruncated: Bool) {
        self.newsText.text = text
        self.indexPath = indexPath
        if isTruncated {
            newsText.numberOfLines = 4
            newsText.lineBreakMode = .byTruncatingTail
        } else {
            newsText.numberOfLines = 0
            newsText.lineBreakMode = .byWordWrapping
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTouched))
        newsText.addGestureRecognizer(tapGesture)
    }
    
    @objc func buttonTouched() { delegate?.didTouchText(at: indexPath) }
}
