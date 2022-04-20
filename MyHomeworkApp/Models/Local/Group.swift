//
//  Group.swift
//  MyHomeworkApp
//
//  Created by Tim on 19.02.2022.
//

import Foundation
import UIKit

struct Group {
    let id: Int
    let name: String
    let avatar: String
}

extension Group: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_100"
    }
}

extension Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.name == rhs.name
    }
}

