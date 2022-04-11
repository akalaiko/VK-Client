//
//  Photo.swift
//  MyHomeworkApp
//
//  Created by Tim on 21.02.2022.
//

import Foundation

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

struct Photo {
    let url: String
    
    init(url: String) {
        self.url = url
    }
}

extension Photo: Codable {
    enum CodingKeys: String, CodingKey {
        case url
    }
}

struct Attachment: Decodable {
    let photo: Photos?
    let video: Video?
}

enum AttachmentType: String, Codable {
    case photo = "photo"
    case video = "video"
}

