//
//  TransitioningDelegate.swift
//  Project-02 TumblrMenu
//
//  Created by fengdaq on 2019/3/13.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit

class TransitioningDelegate: NSObject {
    private var isPresenting = false
}

extension TransitioningDelegate: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        let menuController = transitionContext.viewController(forKey: !self.isPresenting ? UITransitionContextViewControllerKey.from : UITransitionContextViewControllerKey.to) as! MenuViewController
        container.addSubview(menuController.view)
        
        if self.isPresenting {
            self.setBeginAnimation(menuController)
        }
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.95, initialSpringVelocity: 0.8, options: [], animations: {
            // 为了present dismiss都有动画
            if self.isPresenting {
                self.setEndAnimation(menuController)
            } else {
                self.setBeginAnimation(menuController)
            }
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
    func setBeginAnimation(_ menuController: MenuViewController) {
        menuController.view.alpha = 0
        for (index, button) in menuController.buttons.enumerated() {
            button.transform = CGAffineTransform(translationX: 0, y: button.frame.origin.y * CGFloat(index + 2))
        }
    }
    
    func setEndAnimation(_ menuController: MenuViewController) {
        menuController.view.alpha = 1
        for button in menuController.buttons {
            button.transform = CGAffineTransform.identity
        }
    }
    
}

extension TransitioningDelegate: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = false
        return self
    }
    
}
