//
//  PhotoService.swift
//  MyHomeworkApp
//
//  Created by Tim on 15.04.2022.
//

import UIKit
import Alamofire

class PhotoService {
    
    private var images = [String: UIImage]()
    private let container: DataReloadable
    
    init(container: UITableView) { self.container = Table(table: container) }
    init(container: UICollectionView) { self.container = Collection(collection: container) }
    
    private static let pathName: String = {
        let pathName = "images"
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return pathName
    }()
    
    func photo(atIndexPath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexPath: indexPath, byUrl: url)
        }
        
        return image
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let image = UIImage(contentsOfFile: fileName) else { return nil }
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        
        return image
    }
    
    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    private func loadPhoto(atIndexPath indexPath: IndexPath, byUrl url: String) {
        AF.request(url).responseData(queue: .global(qos: .userInteractive)) { [weak self] response in
            guard let data = response.data,
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.saveImageToCache(url: url, image: image)
                self?.images[url] = image
                self?.container.reloadRow(atIndexPath: indexPath)
            }
        }
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.jpegData(compressionQuality: 0.5) else { return }

        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexPath indexPath: IndexPath)
}

extension PhotoService {
    
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexPath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(atIndexPath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
