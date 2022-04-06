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

    func configure (friendName: String, url: String, friendGender: String) {
        self.friendName.text = friendName
        self.friendAvatar.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "default"))
        self.friendGender.text = "Gender: \(friendGender)"
    }
}
