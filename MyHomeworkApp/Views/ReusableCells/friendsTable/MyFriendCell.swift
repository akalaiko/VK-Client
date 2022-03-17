//
//  MyFriendCell.swift
//  MyHomeworkApp
//
//  Created by Tim on 21.12.2021.
//

import UIKit

class MyFriendCell: UITableViewCell {
    @IBOutlet var friendAvatar: UIImageView!
    @IBOutlet var friendName: UILabel!
    @IBAction func avatarPressed() {
        AvatarImage.animateAvatar(friendAvatar)
    }
    func configure(name: String, url: String) {
        self.friendAvatar.downloaded(from: url)
        self.friendName.text = name
    }
}
