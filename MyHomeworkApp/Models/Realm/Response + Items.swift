//
//  RealmService.swift
//  MyHomeworkApp
//
//  Created by Tim on 14.03.2022.
//

import Foundation

struct Response<ItemsType: Decodable>: Decodable {
    let response: Items<ItemsType>
}

struct Items<ItemsType: Decodable>: Decodable {
    let items: [ItemsType]
    let count: Int?
}
