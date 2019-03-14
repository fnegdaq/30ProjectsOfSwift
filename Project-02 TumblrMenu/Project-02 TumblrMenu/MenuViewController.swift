//
//  MenuViewController.swift
//  Project-02 TumblrMenu
//
//  Created by fengdaq on 2019/3/13.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController {
    
    @IBOutlet weak var picButton: CustomButton!
    let f_transitioningDelegate = TransitioningDelegate()
    var buttons = [CustomButton]()
    var buttonsTitle = ["引用","GIF","链接","对话","音频","视频","文字"]
    var buttonsImageName = ["compose_btn_quote_67x66_","compose_btn_gif_66x66_","compose_btn_link_67x66_","compose_btn_chat_67x66_","compose_btn_audio_67x66_","compose_btn_video_67x66_","compose_btn_text_66x66_"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = f_transitioningDelegate
        
        buttons.append(picButton)
        
        for (index, title) in buttonsTitle.enumerated() {

            let radius = Float(120)
            let angle = Double.pi/2 + Double.pi*2/7 * Double(index - 1)
            
            let x = radius * cosf(Float(angle))
            let y = radius * sinf(Float(angle))
            let width = picButton.frame.size.width
            let height = picButton.frame.size.height

            let button = CustomButton(type: .custom)
            button.frame.size = CGSize(width: width, height: height)
            button.center = CGPoint(x: UIScreen.main.bounds.size.width/2 - CGFloat(x), y: UIScreen.main.bounds.size.height/2 - CGFloat(y) - 10)
            button.setTitle(title, for: .normal)
            button.setImage(UIImage.init(named: buttonsImageName[index]), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            self.view.addSubview(button)
            buttons.append(button)
            buttons.sort{$0.frame.origin.y < $1.frame.origin.y}
        }
    }
    
}
