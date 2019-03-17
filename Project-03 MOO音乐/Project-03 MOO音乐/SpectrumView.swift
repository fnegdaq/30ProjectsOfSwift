//
//  SpectrumView.swift
//  Project-03 MOO音乐
//
//  Created by fengdaq on 2019/3/17.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit

class SpectrumView: UIView {
    
    var barWidth: CGFloat = 3.6
    var gap: CGFloat = 1
    
    var leftGradientLayer = CAGradientLayer()
    var rightGradientLayer = CAGradientLayer()
    
    var spectra: [[Float]]? {
        didSet {
            if let spectra = spectra {
                let leftBezierPath = UIBezierPath()
                for (index, amplitude) in spectra[0].enumerated() {
                    let x = (barWidth + gap) * CGFloat(index) + gap
                    let height = CGFloat(amplitude) * bounds.height
                    let barBezierPath = UIBezierPath(rect: CGRect(x: x, y: bounds.height - height, width: barWidth, height: height))
                    leftBezierPath.append(barBezierPath)
                }
                let leftMask = CAShapeLayer()
                leftMask.path = leftBezierPath.cgPath
                leftGradientLayer.frame = self.bounds
                leftGradientLayer.mask = leftMask
                
                if spectra.count >= 2 {
                    let rightBezierPath = UIBezierPath()
                    for (index, amplitude) in spectra[1].enumerated() {
                        let x = CGFloat(spectra[1].count - 1 - index) * (barWidth + gap) + gap
                        let height = CGFloat(amplitude) * bounds.height
                        let barBezierPath = UIBezierPath(rect: CGRect(x: x, y: bounds.height - height, width: barWidth, height: height))
                        rightBezierPath.append(barBezierPath)
                    }
                    let rightMask = CAShapeLayer()
                    rightMask.path = rightBezierPath.cgPath
                    rightGradientLayer.frame = self.bounds
                    rightGradientLayer.mask = rightMask
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        rightGradientLayer.colors = [UIColor.lightGray.cgColor,UIColor.lightGray.cgColor]
        rightGradientLayer.locations = [0.1, 1.0]
        self.layer.addSublayer(rightGradientLayer)
        
        leftGradientLayer.colors = [UIColor.white.cgColor, UIColor.white.cgColor]
        leftGradientLayer.locations = [0.1, 1.0]
        self.layer.addSublayer(leftGradientLayer)
    }

}
