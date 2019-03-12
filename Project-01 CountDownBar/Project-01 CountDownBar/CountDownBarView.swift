//
//  CountDownBarView.swift
//  Project-01 CountDownBar
//
//  Created by fengdaq on 2019/3/12.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit

class CountDownBarView: UIView {
    
    var avatarImageView: UIImageView!
    var nameLabel: UILabel!
    var detailLabel: UILabel!
    var timeLabel: UILabel!
    var timer: Timer?
    var timeTemp: Int?
    var rectangle: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        avatarImageView = UIImageView.init(frame: CGRect(x: 10, y: 10, width: frame.size.height - 20, height: frame.size.height - 20))
        avatarImageView.layer.addSublayer(avatarImageView.drawImage(frame: avatarImageView.bounds, cornerRadius: frame.size.height - 20))
        
        nameLabel = UILabel.init(frame: CGRect(x: avatarImageView.frame.maxX + 10, y: avatarImageView.frame.origin.y, width: 80, height: avatarImageView.frame.height/2 - 5))
        nameLabel.layer.addSublayer(nameLabel.drawImage(frame: nameLabel.bounds, cornerRadius: 2))
        
        detailLabel = UILabel.init(frame: CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.maxY + 10, width: 150, height: nameLabel.frame.height))
        detailLabel.layer.addSublayer(detailLabel.drawImage(frame: detailLabel.bounds, cornerRadius: 2))
        
        timeLabel = UILabel.init(frame: CGRect(x: frame.size.width - 10 - 60, y: frame.size.height - 60 , width: 60, height: 40))
        timeLabel.textAlignment = .right
        timeLabel.textColor = .red
        
        self.addSubview(avatarImageView)
        self.addSubview(nameLabel)
        self.addSubview(detailLabel)
        self.addSubview(timeLabel)
    }
    
    var countDonw_time = String() {
        didSet {
            if let time = Int(countDonw_time), time > 0 {
                timeTemp = time
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
                drawCountDownView(time: time)
                
            }
        }
    }
    
    @objc fileprivate func countDown() {
        timeTemp? -= 1
        if timeTemp! >= 0 {
            timeLabel.text = String(timeTemp!) + "秒"
            if timeTemp! == 0 {
                if timer != nil {
                    timer!.invalidate() 
                    timer = nil
                }
                rectangle?.removeFromSuperlayer()
            }
        }
    }
    
    fileprivate func drawCountDownView(time: Int) {
        if (rectangle != nil) {
            rectangle?.removeFromSuperlayer()
        }
        
        // 规定共60秒，传30秒之类的就会按份数从半途开始倒计
        let each = frame.width/60
        let bezierPath = UIBezierPath.init()
        bezierPath.move(to: CGPoint(x: frame.width, y: 40))
        bezierPath.addLine(to: CGPoint(x: (Int(each) * (60 - time)), y: 40))
        
        rectangle = CAShapeLayer.init()
        rectangle?.strokeColor = UIColor.cyan.cgColor
        rectangle?.lineWidth = frame.height - 2
        rectangle?.path = bezierPath.cgPath
        rectangle?.strokeEnd = 1
        self.layer.sublayers?.insert(rectangle!, at: 1)

        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.duration = Double(timeTemp!);
        animation.fromValue = 1;
        animation.toValue = 0;
        animation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)
        
        rectangle?.add(animation, forKey: "strokeEnd")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
