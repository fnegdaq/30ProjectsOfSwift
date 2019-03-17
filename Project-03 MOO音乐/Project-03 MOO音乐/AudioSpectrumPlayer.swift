//
//  AudioSpectrumPlayer.swift
//  Project-03 MOO音乐
//
//  Created by fengdaq on 2019/3/17.
//  Copyright © 2019 feng. All rights reserved.
//

import Foundation
import AVFoundation
import Accelerate

protocol AudioSpectrumPlayerDelegate: AnyObject {
    func player(_ player: AudioSpectrumPlayer, didGenerateSpectrum spectrum: [[Float]])
}

class AudioSpectrumPlayer {

    weak var delegate: AudioSpectrumPlayerDelegate?
    private let audioEngine = AVAudioEngine()
    private let player = AVAudioPlayerNode()
    var analyzer: RealtimeAnalyzer!
    
    private var bufferSize: Int? {
        didSet {
            if let bufferSize = self.bufferSize {
                analyzer = RealtimeAnalyzer(fftSize: bufferSize)
                audioEngine.mainMixerNode.removeTap(onBus: 0)
                audioEngine.mainMixerNode.installTap(onBus: 0, bufferSize: AVAudioFrameCount(bufferSize), format: nil, block: {[weak self](buffer, when) in
                    guard let strongSelf = self else { return }
                    if !strongSelf.player.isPlaying { return }
                    buffer.frameLength = AVAudioFrameCount(bufferSize)
                    let spectra = strongSelf.analyzer.analyse(with: buffer)
                    if strongSelf.delegate != nil {
                        strongSelf.delegate!.player(strongSelf, didGenerateSpectrum: spectra)
                    }
                })
            }
        }
    }
    
    init(bufferSize: Int = 2048) {
        // mainMixerNode ---> AVAudioPCMBuffer (FFT) ---> output
        audioEngine.attach(player)
        audioEngine.connect(player, to: audioEngine.mainMixerNode, format: nil)
        audioEngine.prepare()
        try! audioEngine.start()

        defer {
            self.bufferSize = bufferSize
        }
    }

    // MARK: Play Functions
    
    func play(fileName: String) {
        guard let audioFileURL = Bundle.main.url(forResource: fileName, withExtension: nil)
            , let audioFile = try? AVAudioFile(forReading: audioFileURL) else { return }
        player.scheduleFile(audioFile, at: nil, completionHandler: nil)
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func stop() {
        player.stop()
    }
    
    func isPlaying() -> Bool {
        return player.isPlaying
    }
    
}
