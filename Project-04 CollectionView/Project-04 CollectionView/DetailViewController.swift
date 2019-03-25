//
//  DetailViewController.swift
//  Project-04 CollectionView
//
//  Created by fengdaq on 2019/3/25.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    var imageView: UIImageView!
    let fdTransitioningDelegate = FD_TransitioningDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = UIImageView(frame: view.bounds)
        view.addSubview(imageView)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_ :)))
        pan.delegate = self
        view.addGestureRecognizer(pan)
        view.isUserInteractionEnabled = true
    }
    
    @objc fileprivate func panGestureAction(_ pan: UIPanGestureRecognizer) {
//        let transition = pan.translation(in: pan.view)
        switch pan.state {
        case .began:()
        case .changed:
            self.dismiss(animated: true, completion: nil)
        case .ended:()
        default:
            break
        }
    }
    
//    private func presentScale(gesture: UIPanGestureRecognizer) -> CGFloat{
//        var present: CGFloat = 0
//        let point = gesture.translation(in: self.view)
//        let y = point.y
//        if y > 0 {
//            let final_y = y > 0 ? y : (y * -1)
//            present = final_y / self.view.frame.size.height
//        }
//        return present
//    }
    
}

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
