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
    
    @IBOutlet var likeButton: UIButton!
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        let likeCount = 0
        
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
    
    func configure (url: String) {

        self.friendPhotoAlbumItem.image = UIImage(named: "default")
        self.friendPhotoAlbumItem.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "default"),
            options: [.transition(.fade(0.2))])
        self.friendPhotoAlbumItem.contentMode = .scaleAspectFill
    }
}



