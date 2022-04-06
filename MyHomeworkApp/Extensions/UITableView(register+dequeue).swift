//
//  UITableView.swift
//  MyHomeworkApp
//
//  Created by Tim on 03.04.2022.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(_ someCell: T.Type) {
        register(UINib(nibName: someCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: someCell.reuseIdentifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(headerFooterView: T.Type) {
        register(UINib(nibName: T.reuseIdentifier, bundle: nil),
            forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for type: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Failed to dequeue view.")
        }
        return view
    }
}
