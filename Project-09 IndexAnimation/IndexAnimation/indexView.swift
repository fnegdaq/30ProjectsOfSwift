//
//  IndexView.swift
//  IndexAnimation
//
//  Created by fengdaq on 2019/4/15.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit

class IndexView: UIView {
    
    var indexArray: [String]? {
        didSet {
            if let indexArray = indexArray {
                let hh: CGFloat = 30.0
                for (index, value) in indexArray.enumerated() {
                    let label = UILabel.init(frame: CGRect(x: 0, y: CGFloat(index) * hh, width: self.frame.width, height: hh))
                    label.text = value
                    label.textAlignment = .center
                    label.textColor = .blue
                    self.addSubview(label)
                }
            }
        }
    }
    
    private lazy var animationLabel: UILabel = {
        let label = UILabel.init()
        label.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        label.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        label.alpha = 0
        label.backgroundColor = .blue
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
}
