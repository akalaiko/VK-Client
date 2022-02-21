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
    @IBOutlet var friendGender: UILabel!
    @IBAction func avatarPressed() {
        AvatarImage.animateAvatar(friendAvatar)
    }

    func configure (friendName: String, url: String, friendGender: String) {
        self.friendName.text = friendName
        self.friendAvatar.downloaded(from: "\(url)")
        self.friendGender.text = "Gender: \(friendGender)"
    }
    
}
