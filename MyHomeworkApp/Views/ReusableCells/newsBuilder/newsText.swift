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
    var textIsTruncated = Bool()
//    {
//        didSet {
//            if textIsTruncated {
//                showMoreButton.setTitle("show more", for: .normal)
//            } else {
//                showMoreButton.setTitle("show less", for: .normal)
//            }
//        }
//    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTouched))
        newsText.addGestureRecognizer(tapGesture)
    }
    
    @objc func buttonTouched() {
        delegate?.didPressButton(at: indexPath)
    }
    
    func configure(text: String, indexPath: IndexPath, textIsTruncated: Bool) {
        self.newsText.text = text
        self.indexPath = indexPath
        self.textIsTruncated = newsText.isTruncated
        if textIsTruncated {
            newsText.numberOfLines = 4
            newsText.lineBreakMode = .byTruncatingTail
        } else {
            newsText.numberOfLines = 0
            newsText.lineBreakMode = .byWordWrapping
        }
//
//        newsText.numberOfLines = 4
//        newsText.lineBreakMode = .byTruncatingTail
        
//        textIsTruncated = newsText.isTruncated
        
        
//        showMoreButton.isHidden = !newsText.isTruncated
//        labelAlone.isActive = !textIsTruncated
//        labelWithButton.isActive = textIsTruncated
        
    }
}
