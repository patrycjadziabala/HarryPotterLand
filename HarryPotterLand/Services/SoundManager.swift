//
//  SoundManager.swift
//  HarryPotterLand
//
//  Created by Patka on 27/03/2024.
//

import Foundation
import AVKit

protocol SoundManagerProtocol {
    func playSound()
    func stopSound()
}

class SoundManager: SoundManagerProtocol {
        
    var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "Harry-Potter-Theme", withExtension: ".mp3") else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
            //alert error playing sound. please try again later
        }
    }
    
    func stopSound() {
        player?.stop()
    }
}
