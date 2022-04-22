//
//  Video.swift
//  MyHomeworkApp
//
//  Created by Tim on 07.04.2022.
//

import Foundation
import UIKit

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

struct Size: Codable {
    let height: Int?
    let url: String
    let width: Int?
    
    var aspectRatio: CGFloat { return CGFloat(height ?? 1)/CGFloat(width ?? 1) }

    enum CodingKeys: String, CodingKey {
        case height, url, width
    }
}
