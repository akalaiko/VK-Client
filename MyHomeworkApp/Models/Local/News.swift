//
//  News.swift
//  MyHomeworkApp
//
//  Created by Tim on 29.03.2022.
//


import Foundation


struct News: Decodable {
    let sourceID: Int
    var avatarURL: String?
    var creatorName: String?
    let date: Double
    var text: String?
    let attachment: [Attachment]?
    let likes: Likes?
    let reposts: Reposts?
    let comments: Comments?
    
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case avatarURL
        case creatorName
        case date
        case text
        case attachment = "attachments"
        case comments
        case likes
        case reposts
    }
}

struct Comments: Codable {
    let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }
}

struct Likes: Codable {
    let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }
}

struct Reposts: Codable {
    let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }
}
