//
//  UICollectionView(register+dequeue).swift
//  MyHomeworkApp
//
//  Created by Tim on 04.04.2022.
//

import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(_ someCell: T.Type) {
        register(UINib(nibName: someCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: someCell.reuseIdentifier)
    }
    
    func register<T: UICollectionReusableView>(header: T.Type) {
        register(UINib(nibName: T.reuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.reuseIdentifier)
        }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        guard let header = dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: T.reuseIdentifier,
                for: indexPath) as? T
        else {
            fatalError("Failed to dequeue header view.")
        }
        return header
    }
}
