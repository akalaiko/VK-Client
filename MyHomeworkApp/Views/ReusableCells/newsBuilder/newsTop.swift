//
//  newsTop.swift
//  MyHomeworkApp
//
//  Created by Tim on 20.01.2022.
//

import UIKit

class newsTop: UITableViewCell {

    @IBOutlet var groupAvatar: UIImageView?
    @IBOutlet var groupName: UILabel?
    @IBOutlet var newsTime: UILabel?
    
    func configure(url: String, name: String, newsTime: String) {
        self.groupAvatar?.image = UIImage(named: "default")
        self.groupAvatar?.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "default"))
        self.groupName?.text = name
        self.newsTime?.text = newsTime
    }
}
