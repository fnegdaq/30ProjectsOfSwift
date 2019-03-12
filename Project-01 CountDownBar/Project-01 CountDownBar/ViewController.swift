//
//  ViewController.swift
//  Project-01 CountDownBar
//
//  Created by fengdaq on 2019/3/12.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let countDownBar = CountDownBarView.init(frame: CGRect(x: 10, y: 100, width: UIScreen.main.bounds.size.width - 20, height: 80))
        countDownBar.layer.sublayers?.insert((countDownBar.drawImage(frame: countDownBar.bounds, cornerRadius: 2, strokeColor: .lightGray)), at: 0)
        countDownBar.countDonw_time = "40"
        self.view.addSubview(countDownBar)
        
    }

}

