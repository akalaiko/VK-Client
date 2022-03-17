//
//  Photo.swift
//  MyHomeworkApp
//
//  Created by Tim on 21.02.2022.
//

import Foundation

struct PhotosResponse {
    let response: Photos
}

extension PhotosResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case response
    }
}

struct Photos {
    let count: Int
    let items: [Albums]
}

extension Photos: Codable {
    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
}

struct Albums {
    let sizes: [Photo]
    let likes: Likes
}

extension Albums: Codable {
    enum CodingKeys: String, CodingKey {
        case sizes
        case likes
    }
}

struct Photo {
    let height: Int
    let url: String
    let type: String
}

extension Photo: Codable {
    enum CodingKeys: String, CodingKey {
        case height
        case url
        case type
    }
}

struct Likes {
    let count: Int
}

extension Likes: Codable {
    enum CodingKeys: String, CodingKey {
        case count
    }
}
