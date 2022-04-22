//
//  Video.swift
//  MyHomeworkApp
//
//  Created by Tim on 07.04.2022.
//

import Foundation

struct Video: Codable {
    let videoDescription: String?
    let duration: Int
    let image: [Photo]
    let title: String
    let type: String
    let views: Int

    enum CodingKeys: String, CodingKey {
        case videoDescription = "description"
        case duration, image
        case title
        case type, views
    }
}
