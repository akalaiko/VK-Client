//
//  Singleton.swift
//  MyHomeworkApp
//
//  Created by Tim on 12.02.2022.
//

import Foundation

final class UserToken {
    var token: String = ""
    var userID: Int = 0
    
    static let instance = UserToken()
    
    private init() { }
}
