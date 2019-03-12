//
//  UIView+DrawPlaceholdLayer.swift
//  Project-01 CountDownBar
//
//  Created by fengdaq on 2019/3/12.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit

extension UIView {
    
    public func drawImage(frame: CGRect, cornerRadius: CGFloat) -> CALayer {
        return drawImage(frame: frame, cornerRadius: cornerRadius, fillColor: .gray)
    }
    
    public func drawImage(frame: CGRect, cornerRadius: CGFloat, fillColor: UIColor) -> CALayer {
        return drawImage(frame: frame, cornerRadius: cornerRadius, fillColor: fillColor, byRoundingCorners: .allCorners)
    }
    
    /*
            ...
     *
     */
    
    public func drawImage(frame: CGRect, cornerRadius: CGFloat, fillColor: UIColor, byRoundingCorners: UIRectCorner) -> CALayer {
        return drawImage(frame, cornerRadius, .white , fillColor, byRoundingCorners)
    }
    
    public func drawImage(frame: CGRect, cornerRadius: CGFloat, strokeColor: UIColor) -> CALayer {
        return drawImage(frame, cornerRadius, strokeColor , .white, .allCorners)
    }
    
    fileprivate func drawImage(_ frame: CGRect, _ cornerRadius: CGFloat, _ strokeColor: UIColor, _ fillColor: UIColor, _ byRoundingCorners: UIRectCorner) -> CALayer {
        let bezierPath = UIBezierPath.init(roundedRect: frame, byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let layer = CAShapeLayer.init()
        layer.lineWidth = 1
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        layer.path = bezierPath.cgPath
        return layer
    }

}
