//
//  Attachments.swift
//  MyHomeworkApp
//
//  Created by Tim on 22.04.2022.
//

import Foundation

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
