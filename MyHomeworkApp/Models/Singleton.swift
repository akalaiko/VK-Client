//
//  Singleton.swift
//  MyHomeworkApp
//
//  Created by Tim on 12.02.2022.
//

import Foundation

final class SingletonModel {
    var token: String = ""
    var userID: Int = 0
    
    static let instance = SingletonModel()
    
    private init() { }
}
