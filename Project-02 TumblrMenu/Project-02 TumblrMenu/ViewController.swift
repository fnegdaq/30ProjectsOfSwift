//
//  ViewController.swift
//  Project-02 TumblrMenu
//
//  Created by fengdaq on 2019/3/13.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func unwindToViewController(_ unwindSegue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
        // Use data from the view controller which initiated the unwind segue
    }
}

