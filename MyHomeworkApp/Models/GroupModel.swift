//
//  GroupModel.swift
//  MyHomeworkApp
//
//  Created by Tim on 21.12.2021.
//

import Foundation
import UIKit

struct GroupsResponse {
    let response: Groups
}

extension GroupsResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case response
    }
}
    
struct Groups {
    let count: Int
    let items: [GroupData]
}

extension Groups: Codable {
    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
}

struct GroupData {
    let id: Int
    let name: String
    let avatar: String
}

extension GroupData: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_100"
    }
}

