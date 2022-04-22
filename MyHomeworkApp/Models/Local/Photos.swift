//
//  Photo.swift
//  MyHomeworkApp
//
//  Created by Tim on 21.02.2022.
//

import Foundation
import UIKit

struct Photos: Codable {
    let sizes: [Photo]
    let likes: Likes?
    let ownerID: Int
    
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
}


