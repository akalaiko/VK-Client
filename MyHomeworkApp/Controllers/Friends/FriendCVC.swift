//
//  FriendsCollectionViewController.swift
//  MyHomeworkApp
//
//  Created by Tim on 18.12.2021.
//

import UIKit
import RealmSwift

final class FriendCVC: UICollectionViewController {
    
    var friend: UserRealm?
    private let networkService = NetworkService<Photos>()
    private var photos: Results<PhotoRealm>? = try? RealmService.load(typeOf: PhotoRealm.self)
    private var photosToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    
        collectionView.register(
            UINib(
                nibName: "FriendPage",
                bundle: nil),
            forCellWithReuseIdentifier: "friendPageCell")
        
        collectionView.register(
            UINib(
                nibName: "FriendCVCHeader",
                bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "friendHeader")
        
        configureLayout()
        networkServiceFunction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        photosToken = photos?.observe { [weak self] photosChanges in
            guard let self = self else { return }
            switch photosChanges {
            case .initial(_):
                self.collectionView.reloadData()
            case let .update(
                _,
                deletions: deletions,
                insertions: insertions,
                modifications: modifications):
                
                let delRowsIndex = deletions.map { IndexPath(
                    row: $0,
                    section: 0) }
                let insertRowsIndex = insertions.map { IndexPath(
                    row: $0,
                    section: 0)}
                let modificationIndex = modifications.map { IndexPath(
                    row: $0,
                    section: 0)}
                
                self.collectionView.deleteItems(at: delRowsIndex)
                self.collectionView.insertItems(at: insertRowsIndex)
                self.collectionView.reloadItems(at: modificationIndex)
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        photosToken?.invalidate()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { photos?.count ?? 0 }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "friendHeader",
                for: indexPath) as? FriendCVCHeader
        else { return UICollectionReusableView() }
        
        guard let currentFriend = friend else { return UICollectionViewCell() }
    
        header.configure(
            friendName: currentFriend.fullName,
            url: currentFriend.photoBig,
            friendGender: (currentFriend.sex == 1) ? "female":"male" )
        
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "friendPageCell",
            for: indexPath) as? FriendPage
        else { return UICollectionViewCell() }
        
        cell.configure(url: photos?[indexPath.row].url ?? "")
        
        return cell
    }
    
    func configureLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width

        layout.headerReferenceSize = CGSize(width: width, height: 120)
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "showPhoto") as? LargePhoto {
            vc.photos = photos!
            vc.chosenPhotoIndex = indexPath.row
//            vc.friend = friend
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    func networkServiceFunction() {
        networkService.fetch(type: .photos, id: friend!.id){ [weak self] result in
            switch result {
            case .success(let photos):
                DispatchQueue.main.async {
                    let photoRealm = photos.map { PhotoRealm(ownerID: self?.friend?.id ?? 0, photo: $0) }
                    do {
                    try RealmService.save(items: photoRealm)
                        self?.photos = try RealmService.load(typeOf: PhotoRealm.self).filter("ownerID == %@", self?.friend?.id ?? "")
                    self?.collectionView.reloadData()
                    } catch {
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
