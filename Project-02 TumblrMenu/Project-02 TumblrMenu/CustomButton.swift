
//
//  CustomButton.swift
//  Project-02 TumblrMenu
//
//  Created by fengdaq on 2019/3/13.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame.origin.x = 0
        self.imageView?.frame.origin.y = 0
        self.imageView?.frame.size.width = frame.size.width
        self.imageView?.frame.size.height = frame.size.width
        self.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        self.titleLabel?.frame.origin.y = frame.size.width + 6
        self.titleLabel?.frame.origin.x = 0
        self.titleLabel?.frame.size.width = frame.size.width
        self.titleLabel?.frame.size.height = frame.size.height - frame.size.width
        self.titleLabel?.textAlignment = .center
        
    }

}
