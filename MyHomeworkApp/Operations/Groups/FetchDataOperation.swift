//
//  GetDataOperation.swift
//  MyHomeworkApp
//
//  Created by Tim on 06.04.2022.
//

import Foundation
import RealmSwift

class FetchDataOperation: AsyncOperation {
    var networkService = NetworkService<Group>()
    var fetchedData: [Group]?

    override func main() {
        DispatchQueue.global().async {
            self.networkService.fetch(type: .groups) { [weak self] fetchResult in
                switch fetchResult {
                case .failure(let error): print(error)
                case .success(let data):
                    self?.fetchedData = data.compactMap { $0 }
                    self?.state = .finished
                }
            }
        }
    }
}


