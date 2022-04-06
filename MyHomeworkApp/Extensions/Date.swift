//
//  PhotoRealm.swift
//  MyHomeworkApp
//
//  Created by Tim on 14.03.2022.
//

import Foundation
import UIKit

extension Date {
    enum DateFormat: String {
        case dateTime = "dd.MM.yy, HH:mm"
        case date = "dd.MM.yy"
    }
    
    func toString(dateFormat: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: self)
    }
}
