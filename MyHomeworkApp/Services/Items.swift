//
//  RealmService.swift
//  MyHomeworkApp
//
//  Created by Tim on 14.03.2022.
//

import Foundation

struct Items<ItemsType: Decodable>: Decodable {
    let items: [ItemsType]
    let count: Int?
}
