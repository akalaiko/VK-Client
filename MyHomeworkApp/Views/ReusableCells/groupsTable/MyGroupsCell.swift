//
//  MyGroupsCell.swift
//  MyHomeworkApp
//
//  Created by Tim on 21.12.2021.
//

import UIKit

class MyGroupsCell: UITableViewCell {
    @IBOutlet var groupAvatar: UIImageView!
    @IBOutlet var groupName: UILabel!
    @IBAction func avatarPressed() {
        AvatarImage.animateAvatar(groupAvatar)
    }
    
    func configure(name: String, url: String) {
        self.groupAvatar.image = nil
        self.groupAvatar.downloaded(from: url)
        self.groupName.text = name
    }
    
}
