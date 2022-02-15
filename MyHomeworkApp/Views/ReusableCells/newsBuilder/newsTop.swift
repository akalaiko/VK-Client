//
//  newsTop.swift
//  MyHomeworkApp
//
//  Created by Tim on 20.01.2022.
//

import UIKit

class newsTop: UITableViewCell {

    @IBOutlet var groupAvatar: UIImageView!
    @IBOutlet var groupName: UILabel!
    @IBOutlet var newsTime: UILabel!
    
    func configure(avatar: UIImage?, name: String, newsTime: String) {
        self.groupAvatar.image = avatar
        self.groupName.text = name
        self.newsTime.text = newsTime
    }
}
