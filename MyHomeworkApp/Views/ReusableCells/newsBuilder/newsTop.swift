//
//  newsTop.swift
//  MyHomeworkApp
//
//  Created by Tim on 20.01.2022.
//

import UIKit

class newsTop: UITableViewCell {

    @IBOutlet var sourcePhoto: UIImageView?
    @IBOutlet var sourceName: UILabel?
    @IBOutlet var newsTime: UILabel?
    
    func configure(url: String, name: String, newsTime: String) {
        self.sourcePhoto?.image = UIImage(named: "default")
        self.sourcePhoto?.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "default"))
        self.sourceName?.text = name
        self.newsTime?.text = newsTime
    }
}
