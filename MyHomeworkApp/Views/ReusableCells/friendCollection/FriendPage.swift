//
//  FriendPage.swift
//  MyHomeworkApp
//
//  Created by Tim on 21.12.2021.
//

import UIKit
import Kingfisher

class FriendPage: UICollectionViewCell {

    @IBOutlet var friendPhotoAlbumItem: UIImageView!
    var likeCount = 0
    
    @IBOutlet var likeButton: UIButton!
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        sender.isSelected  = !sender.isSelected
        
        if sender.isSelected {
            animateLike(sender, "heart.fill")
            sender.setTitle("\(likeCount + 1)", for: .normal)
        } else {
            animateLike(sender, "heart")
            sender.setTitle("\(likeCount)", for: .normal)
        }
    }

    func animateLike(_ sender: UIButton, _ imageName: String) {
        UIView.transition(
            with: sender.imageView!,
            duration: 0.5,
            options: [ .transitionFlipFromLeft])
        {
            sender.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    func configure (url: String, likes: Int) {

        self.friendPhotoAlbumItem.image = UIImage(named: "default")
        self.friendPhotoAlbumItem.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "default"),
            options: [.transition(.fade(0.2))])
        self.friendPhotoAlbumItem.contentMode = .scaleAspectFill
        self.likeCount = likes
        self.likeButton.setTitle("\(likeCount)", for: .normal)
        self.likeButton.backgroundColor = .white.withAlphaComponent(0.7)
        self.likeButton.layer.cornerRadius = 5.0
//        self.likeButton.backgroundColor.al
    }
}



