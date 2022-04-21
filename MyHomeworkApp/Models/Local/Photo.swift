//
//  Photo.swift
//  MyHomeworkApp
//
//  Created by Tim on 21.02.2022.
//

import Foundation
import UIKit

struct Photos {
    let sizes: [Photo]
    let likes: Likes?
    let ownerID: Int
}

extension Photos: Codable {
    enum CodingKeys: String, CodingKey {
        case sizes
        case likes
        case ownerID = "owner_id"
    }
}

struct Photo: Codable {
    let type: String?
    let url: String
    let width: Int?
    let height: Int?

    var aspectRatio: CGFloat { return CGFloat(height ?? 1)/CGFloat(width ?? 1) }
    
//    init(url: String) {
//        self.url = url
//    }
}

//extension Photo: Codable {
//    enum CodingKeys: String, CodingKey {
//        case url
//    }
//}

struct Attachment: Decodable {
    let photo: Photos?
    let video: Video?
    let link: Link?
    
}

enum AttachmentType: String, Codable {
    case photo = "photo"
    case video = "video"
    case link = "link"
}

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


