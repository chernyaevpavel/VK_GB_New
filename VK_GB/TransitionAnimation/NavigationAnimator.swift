//
//  NavigationAnimator.swift
//  VK_GB
//
//  Created by Павел Черняев on 19.05.2021.
//

import UIKit

class NavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private var duration: TimeInterval = 0.6
    private let isPresent: Bool
    
    init(isPresent: Bool) {
        self.isPresent = isPresent
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        if isPresent {
            if let _ = source as? FriendPhotosCollectionViewController {
                pushPhoto(using: transitionContext)
            } else {
                push(using: transitionContext)
            }
        } else {
            if let _ = source as? FriendPhotoAnimationViewController {
                popPhoto(using: transitionContext)
            } else {
                pop(using: transitionContext)
            }
        }
    }
    
    private func popPhoto(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.addSubview(source.view)
        destination.view.frame = source.view.frame
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: []) {
            source.view.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            source.view.alpha = 0
        } completion: { result in
            transitionContext.completeTransition(result && !transitionContext.transitionWasCancelled)
        }
    }
    
    private func pushPhoto(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        destination.view.alpha = 0
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: []) {
            destination.view.transform = CGAffineTransform(scaleX: 1, y: 1)
            destination.view.alpha = 1
        } completion: { result in
            transitionContext.completeTransition(result && !transitionContext.transitionWasCancelled)
        }
    }
    
    private func push(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        setAnchorPoint(anchorPoint: CGPoint(x: 1, y: 0), forView: destination.view)
        destination.view.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi) / 2)
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: []) {
            destination.view.transform = CGAffineTransform(rotationAngle: 0)
        } completion: { result in
            
            transitionContext.completeTransition(result && !transitionContext.transitionWasCancelled)
            
        }
    }
    
    private func pop(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.addSubview(source.view)
        destination.view.frame = source.view.frame
        setAnchorPoint(anchorPoint: CGPoint(x: 1, y: 0), forView: source.view)
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: []) {
            source.view.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi) / 2)
            source.view.alpha = 0
        } completion: { result in
//            if result && !transitionContext.transitionWasCancelled {
//                source.removeFromParent()
//            }
            transitionContext.completeTransition(result && !transitionContext.transitionWasCancelled)
        }
    }
}
