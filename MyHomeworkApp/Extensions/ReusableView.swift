//
//  ReusableView.swift.swift
//  MyHomeworkApp
//
//  Created by Tim on 03.04.2022.
//

import Foundation
import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String { String(describing: self) }
}

extension UITableViewCell: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}
extension UICollectionReusableView: ReusableView {}
