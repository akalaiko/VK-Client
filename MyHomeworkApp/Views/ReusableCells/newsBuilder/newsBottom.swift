//
//  newsBottom.swift
//  MyHomeworkApp
//
//  Created by Tim on 20.01.2022.
//

import UIKit


class newsBottom: UITableViewCell {
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var commentsButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    
    func configure(isLiked: Bool, likesCounter: Int, commentCounter: Int, shareCounter: Int) {
        if isLiked {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.setTitle("\(likesCounter)", for: .normal)
            likeButton.tintColor = .systemBlue
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.setTitle("\(likesCounter)", for: .normal)
            likeButton.tintColor = .darkGray
        }
        
        commentsButton.setTitle("\(commentCounter)", for: .normal)
        shareButton.setTitle("\(shareCounter)", for: .normal)

    }
}
