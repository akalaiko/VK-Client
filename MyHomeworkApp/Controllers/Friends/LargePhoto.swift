//
//  largePhoto.swift
//  MyHomeworkApp
//
//  Created by Tim on 25.01.2022.
//

import UIKit
import RealmSwift

final class LargePhoto: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var photo: UIImageView!
    var photos: Results<PhotoRealm>? = try? RealmService.load(typeOf: PhotoRealm.self)
    var chosenPhotoIndex = Int()
    private var photoSubview = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let photos = photos else { return }

        title = "Photo \(chosenPhotoIndex + 1) of \(photos.count)"
        photo.kf.setImage(with: URL(string: photos[chosenPhotoIndex].url))

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipePhoto(_:)))
            swipeRight.direction = .right
            view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipePhoto(_:)))
            swipeLeft.direction = .left
            view.addGestureRecognizer(swipeLeft)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipePhoto(_:)))
            swipeDown.direction = .down
            view.addGestureRecognizer(swipeDown)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool { true }
    
    @objc func swipePhoto(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            setupSubview(on: .right)
            animateFlip()
        case .right:
            setupSubview(on: .left)
            animateFlip()
        case .down:
            navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
    
    func animateFlip() {
        UIView.animateKeyframes(
            withDuration: 0.5,
            delay: 0.0,
            options: [.calculationModeLinear] ) {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 1) { [self] in
                        photoSubview.frame.size.width = view.bounds.width
                        self.photoSubview.center.y = self.photo.center.y
                    }
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.75) {
                        self.photo.alpha = 0
                    }
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.5) {
                        self.photoSubview.center.x = self.photo.center.x
                    }
            } completion: { isCompleted in
                self.photo.image = self.photoSubview.image
                self.photo.alpha = 1
                self.photoSubview.removeFromSuperview()
            }
    }
    
    func setupSubview(on side: UISwipeGestureRecognizer.Direction) {
        photoSubview.frame.size.width = view.bounds.width * 0.5
        photoSubview.frame.size.height = photo.frame.size.height
        photoSubview.center.y = photo.center.y
        photoSubview.contentMode = .scaleAspectFit

        switch side {
        case .right:
        photoSubview.center.x = photo.center.x * 2 + photoSubview.frame.size.width / 2
           if chosenPhotoIndex + 1 < photos!.count {
               chosenPhotoIndex += 1
           } else {
               chosenPhotoIndex = 0
           }
        case .left:
        photoSubview.center.x = -photo.center.x * 2 - photoSubview.frame.size.width / 2
           if chosenPhotoIndex - 1 >= 0 {
               chosenPhotoIndex -= 1
           } else {
               chosenPhotoIndex = photos!.count - 1
           }
        default:
            break
        }
        photoSubview.kf.setImage(with: URL(string: photos![chosenPhotoIndex].url))
        title = "Photo \(chosenPhotoIndex + 1) of \(photos!.count)"
        view.addSubview(photoSubview)
       }
}
