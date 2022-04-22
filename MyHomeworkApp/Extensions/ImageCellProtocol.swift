//
//  ImageCellProtocol.swift
//  MyHomeworkApp
//
//  Created by Tim on 20.04.2022.
//

import UIKit

protocol ImageCellDelegate {
    func didSelectImage( photos: [String], currentIndex: Int)
}
