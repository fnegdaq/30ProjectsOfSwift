//
//  ViewController.swift
//  Project-04 CollectionView
//
//  Created by fengdaq on 2019/3/18.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var backgroundImageView : UIImageView!
    var collectionView : UICollectionView!
    var layout = FD_CollectionLayout()
    
    var beginPoint = CGPoint(x: 0, y: 0)
    var endPoint = CGPoint(x: 0, y: 0)
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage.init(named: "WechatIMG30.jpeg")
        view.addSubview(backgroundImageView)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        view.addSubview(blurView)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FD_CollectionCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        collectionView.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! FD_CollectionCell
        cell.imageView.image = UIImage.init(named: "WechatIMG3\(indexPath.item).jpeg")
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        beginPoint = scrollView.contentOffset
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        endPoint = scrollView.contentOffset
        
        let dragMinDistence = collectionView.bounds.width/15
        if endPoint.x - beginPoint.x > dragMinDistence {
            currentIndex += 1
        } else if beginPoint.x - endPoint.x > dragMinDistence {
            currentIndex -= 1
        }

        let count  = collectionView.numberOfItems(inSection: 0) - 1;
        currentIndex = currentIndex <= 0 ? 0 : currentIndex;
        currentIndex = currentIndex >= count ? count : currentIndex;
        
        DispatchQueue.main.async {
            self.backgroundImageView.image = UIImage.init(named: "WechatIMG3\(self.currentIndex).jpeg")
            self.collectionView.scrollToItem(at: NSIndexPath.init(row: self.currentIndex, section: 0) as IndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
    }
}
