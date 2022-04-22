//
//  Links.swift
//  MyHomeworkApp
//
//  Created by Tim on 22.04.2022.
//

import Foundation

struct Link: Codable {
    let url: String
    let linkDescription: String?
    let photo: Photos?
    let title: String
    let caption: String?

    enum CodingKeys: String, CodingKey {
        case url
        case linkDescription = "description"
        case photo, title, caption
    }
}
