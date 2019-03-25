//
//  FD_TransitioningDelegate.swift
//  Project-04 CollectionView
//
//  Created by fengdaq on 2019/3/25.
//  Copyright © 2019 feng. All rights reserved.
//

import Foundation
import UIKit

class FD_TransitioningDelegate: NSObject {
    private var isPresenting = false
    private var positionTemp = CGRect.zero
    private var itemTemp: FD_CollectionCell?
    
    func fd_Presend(_ from: UIViewController, _ to: UIViewController, _ item: FD_CollectionCell, _ itemPosition: CGRect) -> Void {
        itemTemp = item
        positionTemp = itemPosition
        to.transitioningDelegate = self
        from.present(to, animated: true, completion: nil)
    }
}

extension FD_TransitioningDelegate: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = false
        return self
    }
}


extension FD_TransitioningDelegate: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        // 两个视图角色可能来回切换
        let screens: (from: UIViewController, to: UIViewController) = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!, transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)
        let detailViewController = !self.isPresenting ? screens.from as! DetailViewController : screens.to as! DetailViewController
        let bottomViewController = !self.isPresenting ? screens.to as UIViewController : screens.from as UIViewController
        
        if self.isPresenting {
            offStageDetail(detailViewController)
        }
        
        container.addSubview(bottomViewController.view!)
        container.addSubview(detailViewController.view!)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [], animations: {
            if self.isPresenting {
                self.onStageDetail(detailViewController)
            } else {
                self.offStageDetail(detailViewController)
            }
        }) { (_) in
            transitionContext.completeTransition(true)
        }
        
    }
    
    private func offStageDetail(_ detailViewController: DetailViewController) {
        let rect = detailViewController.view.convert(positionTemp, to: detailViewController.view)
        detailViewController.imageView.image = self.itemTemp?.imageView.image
        detailViewController.imageView.frame = rect
        detailViewController.imageView.layer.cornerRadius = 10
        detailViewController.imageView.layer.masksToBounds = true
    }
    
    private func onStageDetail(_ detailViewController: DetailViewController) {
        detailViewController.imageView.frame = detailViewController.view.bounds
    }
}


