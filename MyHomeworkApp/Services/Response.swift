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

