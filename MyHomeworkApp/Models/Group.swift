//
//  Group.swift
//  MyHomeworkApp
//
//  Created by Tim on 19.02.2022.
//

import Foundation
import UIKit

struct Group {
    
    var name: String
    var avatar: String? = nil
    
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = avatar
    }
    
}

extension Group: Equatable {
    
    static func ==(lhs: Group, rhs: Group) -> Bool {
        return lhs.name == rhs.name
    }
}

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

