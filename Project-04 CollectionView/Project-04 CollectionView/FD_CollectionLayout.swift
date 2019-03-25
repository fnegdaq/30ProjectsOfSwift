//
//  FD_CollectionLayout.swift
//  Project-04 CollectionView
//
//  Created by fengdaq on 2019/3/18.
//  Copyright © 2019 feng. All rights reserved.
//

import Foundation
import UIKit

class FD_CollectionLayout: UICollectionViewFlowLayout {

    let item_width: CGFloat = UIScreen.main.bounds.size.width - 80
    let item_height: CGFloat = UIScreen.main.bounds.size.height - 200
    
    override init() {
        super.init()
        self.itemSize = CGSize(width: item_width, height: item_height);
        self.scrollDirection = UICollectionView.ScrollDirection.horizontal;
        self.minimumLineSpacing = 15;
    }
    
    override func prepare() {
        self.sectionInset = UIEdgeInsets(top: 10, left: 40, bottom: 10, right: 40)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let attributes = NSArray(array: super.layoutAttributesForElements(in: rect)!, copyItems: true) as! [UICollectionViewLayoutAttributes]
        // collectionView 当前显示的区域
        let visibleRect = CGRect(x: self.collectionView?.contentOffset.x ?? 0, y: 0, width: self.collectionView?.bounds.width ?? UIScreen.main.bounds.width, height: self.collectionView?.bounds.height ?? UIScreen.main.bounds.height)

        for attribute in attributes {
            if visibleRect.intersects(attribute.frame) {
                // 按中心间距比例
                let distance = abs(visibleRect.midX - attribute.center.x)
                let distanceScale = distance / (self.collectionView?.bounds.width ?? UIScreen.main.bounds.width)
                // 根据余弦曲线图 -pi/2~0~pi/2 之间，数值越小，变形越小, 越接近卡片高度 y = cos(x) 最高1
                let scale = abs(cos(Double(distanceScale) * Double.pi/5))
                attribute.transform = CGAffineTransform(scaleX: 1.0, y: CGFloat(scale))
            }
        }
        return attributes
    }
    
    /**
        无限滚动停止时自动居中
     
    // proposedContentOffset 停下后最终的偏移量
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        let visibleRect = CGRect(x: proposedContentOffset.x, y: 0, width: self.collectionView?.bounds.size.width ?? UIScreen.main.bounds.width, height: self.collectionView?.bounds.height ?? UIScreen.main.bounds.height)
        let attributes = layoutAttributesForElements(in: visibleRect)
        var adjustOffsetX = CGFloat(MAXFLOAT)
        let center_x = proposedContentOffset.x + (self.collectionView?.bounds.width ?? UIScreen.main.bounds.width ) / 2
        
        for attribute in attributes! {
            if abs(attribute.center.x - center_x) < abs(adjustOffsetX) {
                adjustOffsetX = attribute.center.x - center_x
            }
        }
        return CGPoint(x: proposedContentOffset.x + adjustOffsetX, y: 0.0)
    }
 
    */

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
