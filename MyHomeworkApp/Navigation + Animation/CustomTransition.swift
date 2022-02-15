//
//  CustomTransition.swift
//  MyHomeworkApp
//
//  Created by Tim on 26.01.2022.
//

import UIKit

final class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var isStarted = false
    var shouldFinish = false
}

final class CustomNavController: UINavigationController, UINavigationControllerDelegate {
    
    let pushAnimation = PushAnimation()
    let popAnimation = PopAnimation()
    let pushPhoto = PushPhoto()
    let popPhoto = PopPhoto()
    
    private let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        let edgePanLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePan(_:)))
        edgePanLeft.edges = .left
        view.addGestureRecognizer(edgePanLeft)

    }
    
    @objc func edgePan(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveTransition.isStarted = true
            popViewController(animated: true)
        case .changed:
            guard
                let width = recognizer.view?.bounds.width
            else {
                interactiveTransition.isStarted = false
                interactiveTransition.cancel()
                return
            }
    
            let translation = recognizer.translation(in: view)
            let relationTranslation = translation.x / width
            let progress = max(0, min(relationTranslation, 1))
            interactiveTransition.update(progress)
            interactiveTransition.shouldFinish = progress > 0.35
        case .ended:
            interactiveTransition.isStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()
        case .failed,
                .cancelled:
            interactiveTransition.isStarted = false
            interactiveTransition.cancel()
            
        default:
            break
        }
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            if fromVC is LargePhoto {
                return popPhoto
            }
            if toVC is LargePhoto {
                    return nil
                } else {
                switch operation {
                case .push:
                    return pushAnimation
                case .pop:
                    return popAnimation
                default:
                    return nil
                }
            }
        }
    
    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
            return interactiveTransition.isStarted ? interactiveTransition : nil
    }
    
}
