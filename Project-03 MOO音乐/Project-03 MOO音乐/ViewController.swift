//
//  ViewController.swift
//  Project-03 MOO音乐
//
//  Created by fengdaq on 2019/3/17.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playMask: UIButton!
    
    var player: AudioSpectrumPlayer!
    
    @IBOutlet weak var spectrumView: SpectrumView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        player = AudioSpectrumPlayer()
        player.delegate = self

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if player.isPlaying() == false {
            let paths =  Bundle.main.paths(forResourcesOfType: ".mp3", inDirectory: nil)
            let musicPaths = paths.map { $0.components(separatedBy: "/").last }
            player.play(fileName: musicPaths[0]!)
            playMask.isHidden = true
        } else {
            player.pause()
            playMask.isHidden = false
        }
    }

}

extension ViewController: AudioSpectrumPlayerDelegate {
    func player(_ player: AudioSpectrumPlayer, didGenerateSpectrum spectrum: [[Float]]) {
        DispatchQueue.main.async {
            self.spectrumView.spectra = spectrum
        }
    }
}

