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

    func configure(name: String, url: String) {
        self.friendAvatar.image = nil
        self.friendAvatar.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "default"))
        self.friendName.text = name
    }
}
