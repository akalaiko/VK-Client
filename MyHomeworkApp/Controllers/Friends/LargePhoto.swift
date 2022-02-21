//
//  largePhoto.swift
//  MyHomeworkApp
//
//  Created by Tim on 25.01.2022.
//

import UIKit

class LargePhoto: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet var photo: UIImageView!
    
    var friend: User?
    var photos = [String]()
    var chosenPhotoIndex = Int()
    var photoSubview = UIImageView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photo \(chosenPhotoIndex + 1) of \(photos.count)"
        photo.downloaded(from: photos[chosenPhotoIndex])
        photo.isUserInteractionEnabled = true
        photo.contentMode = .scaleAspectFill
        photoSubview.contentMode = .scaleAspectFill


        
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
    
    override func viewWillDisappear(_ animated: Bool = false) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "friendCVC") as? FriendCVC {
            vc.friend = friend
            FriendCVC.freakingIndex = chosenPhotoIndex
            
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
    
    @objc func swipePhoto(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .left:
                setupSubview(on: .right)
                animateFlip()
            case .right:
                setupSubview(on: .left)
                animateFlip()
            case .down:
                navigationController?.popViewController(animated: false)
            default:
                break
            }
        }
    }
    
    func animateFlip() {
        view.layoutIfNeeded()
        
        UIView.animateKeyframes(
            withDuration: 1.0,
            delay: 0.0,
            options: [
                .calculationModeLinear
            ]) {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 1) { [self] in
                        photoSubview.frame.size.width = view.bounds.width
                        photoSubview.frame.size.height = photoSubview.frame.size.width
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
                self.photo.downloaded(from: self.photos[self.chosenPhotoIndex])
                self.photo.alpha = 1
                self.view.layoutIfNeeded()
            }
        
    }
    
    func setupSubview(on side: UISwipeGestureRecognizer.Direction) {
        photoSubview.frame.size.width = view.bounds.width * 0.5
        photoSubview.frame.size.height = photoSubview.frame.size.width
        photoSubview.center.y = photo.center.y

        switch side {
        case .right:
        photoSubview.center.x = photo.center.x * 2 + photoSubview.frame.size.width / 2
           if chosenPhotoIndex + 1 < photos.count {
               chosenPhotoIndex += 1
           } else {
               chosenPhotoIndex = 0
           }
        case .left:
        photoSubview.center.x = -photo.center.x * 2 - photoSubview.frame.size.width / 2
           if chosenPhotoIndex - 1 >= 0 {
               chosenPhotoIndex -= 1
           } else {
               chosenPhotoIndex = photos.count - 1
           }
        default:
            break
        }
        
        photoSubview.downloaded(from: photos[chosenPhotoIndex])
        title = "Photo \(chosenPhotoIndex + 1) of \(photos.count)"
        view.addSubview(photoSubview)
       }

}
