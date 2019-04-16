//
//  IndexView.swift
//  IndexAnimation
//
//  Created by fengdaq on 2019/4/15.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit

class IndexView: UIView {
    
    let indexLabel_height: CGFloat = 30.0
    let font_size: CGFloat = 14
    let radius: CGFloat = 70
    let font_rate: CGFloat = 1/8
    let viewtag: Int = 10086
    
    var selectIndex: ((_ index: Int) -> ())?
    
    var indexArray: [String]? {
        didSet {
            if let indexArray = indexArray {
                for (index, value) in indexArray.enumerated() {
                    let label = UILabel.init(frame: CGRect(x: 0, y: CGFloat(index) * indexLabel_height, width: self.frame.width, height: indexLabel_height))
                    label.tag = index + viewtag
                    label.text = value
                    label.textAlignment = .center
                    label.textColor = .black
                    label.font = UIFont.systemFont(ofSize: font_size)
                    self.addSubview(label)
                    self.addSubview(animationLabel)
                }
            }
        }
    }

    private lazy var animationLabel: UILabel = {
        let label = UILabel.init()
        label.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        label.center = CGPoint(x: -UIScreen.main.bounds.width/2 + self.frame.width, y: self.frame.height/2)
        label.alpha = 0.0
        label.backgroundColor = .cyan
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    private func panAnimationBegin(touches: Set<UITouch>) {
        for touch:AnyObject in touches {
            let touch = touch as! UITouch
            let touchPoint = touch.location(in: self)
            
            for (index, value) in indexArray!.enumerated() {
                let label = self.viewWithTag(index + viewtag) as! UILabel
                if abs(label.center.y - touchPoint.y) <= radius {
                    UIView.animate(withDuration: 0.2) {
                        // 勾股定理
                        let center_x = label.frame.width/2 - sqrt(pow(self.radius, 2) - pow(abs(label.center.y - touchPoint.y), 2) )
                        label.center = CGPoint(x: center_x, y: label.center.y)
                        label.font = UIFont.systemFont(ofSize: self.font_size + (self.radius - abs(label.center.y - touchPoint.y)) * self.font_rate)

                        // 设定规则当差值小于多少时切换为下一个
                        if abs(label.center.y - touchPoint.y) <= 6.5 {
                            label.textColor = .red
                            label.alpha = 1.0
                          
                            self.selectIndex?(index)
                            self.animationLabel.text = value
                            self.animationLabel.alpha = 1.0
                            
                            for (i, _) in self.indexArray!.enumerated() {
                                let label_next = self.viewWithTag(self.viewtag + i) as! UILabel
                                if index != i {
                                    label_next.textColor = .black
                                }
                            }
                        }
                    }
                } else {
                    // 不在点击区域的恢复原样
                    UIView.animate(withDuration: 0.2) {
                        label.center = CGPoint(x: self.frame.width/2, y: label.center.y)
                        label.alpha = 1.0
                        label.font = UIFont.systemFont(ofSize: self.font_size)
                    }
                }
            }
        }
    }
    
    private func panAnimationEnd(touches: Set<UITouch>) {
        for (index, _) in indexArray!.enumerated() {
            let label = self.viewWithTag(index + viewtag) as! UILabel
            UIView.animate(withDuration: 0.2) {
                label.center = CGPoint(x: self.frame.width/2, y: CGFloat(index) * self.indexLabel_height + self.indexLabel_height/2)
                label.font = UIFont.systemFont(ofSize: self.font_size)
                label.alpha = 1.0
                label.textColor = .black
                
                self.animationLabel.alpha = 0
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        panAnimationBegin(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        panAnimationBegin(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        panAnimationEnd(touches: touches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        panAnimationEnd(touches: touches)
    }
    
}
