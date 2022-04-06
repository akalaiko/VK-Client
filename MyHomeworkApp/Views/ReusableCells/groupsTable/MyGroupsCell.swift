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

    func configure(name: String, url: String) {
        self.groupAvatar.image = UIImage(named: "default")
        self.groupAvatar.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "default"))
        self.groupName.text = name
    }
    
}
