//
//  newsText.swift
//  MyHomeworkApp
//
//  Created by Tim on 20.01.2022.
//

import UIKit

class newsText: UITableViewCell {

    @IBOutlet var newsText: UILabel!
    
    func configure(text: String) {
        self.newsText.text = text
    }
}
