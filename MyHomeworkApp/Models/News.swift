//
//  News.swift
//  MyHomeworkApp
//
//  Created by Tim on 29.03.2022.
//


import Foundation


struct News {
    
    let sourceID: Int
    let date: Double
    var text: String?
    let photosURLs: [Attachment]?
    let likes: Likes
    let reposts: Reposts
    let comments: Comments
}

extension News: Decodable {
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case text
        case photosURLs = "attachments"
        case comments
        case likes
        case reposts
    }
}

extension News: Comparable {
    static func < (lhs: News, rhs: News) -> Bool {
        lhs.date < rhs.date
    }
    
    static func == (lhs: News, rhs: News) -> Bool {
        lhs.date == rhs.date && lhs.sourceID == rhs.sourceID
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

//struct Views: Codable {
//    let count: Int
//}

struct Reposts: Codable {
    let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }
}
