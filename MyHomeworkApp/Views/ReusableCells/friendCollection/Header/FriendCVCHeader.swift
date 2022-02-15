//
//  FriendCVCHeader.swift
//  MyHomeworkApp
//
//  Created by Tim on 28.12.2021.
//

import UIKit

class FriendCVCHeader: UICollectionReusableView {

    @IBOutlet var friendName: UILabel!
    @IBOutlet var friendAvatar: UIImageView!
    @IBOutlet var friendAge: UILabel!
    @IBOutlet var friendGender: UILabel!
    @IBAction func avatarPressed() {
        AvatarImage.animateAvatar(friendAvatar)
    }

    func configure (friendName: String, friendAvatar: UIImage, friendAge: UInt8, friendGender: String) {
        self.friendName.text = friendName
        self.friendAvatar.image = friendAvatar
        self.friendAge.text = "Age: \(friendAge)"
        self.friendGender.text = "Gender: \(friendGender)"
    }
    
}
