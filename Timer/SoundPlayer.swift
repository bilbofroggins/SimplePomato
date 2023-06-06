//
//  SoundPlayer.swift
//  Timer
//
//  Created by Patrick Cunniff on 6/4/23.
//

import AVFoundation
class SoundPlayer {
    var audioPlayer: AVAudioPlayer?
    var volume: Float = 1.0 // Volume property with default value of 1.0
    
    init() {
        prepareAudioPlayer()
    }
    
    func prepareAudioPlayer() {
        guard let soundURL = Bundle.main.url(forResource: "beep", withExtension: "mp3") else {
            fatalError("Sound file not found")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
        } catch {
            print("Failed to create audio player: \(error)")
        }
    }
    
    func playSound(volume: Int) {
        audioPlayer?.play()
        audioPlayer?.volume = (Float(volume)/100)
    }
    
    func playTestSound(volume: Int) {
        audioPlayer?.numberOfLoops = 0
        audioPlayer?.volume = (Float(volume)/100)
        
        let delegate = SoundPlayerDelegate()
        audioPlayer?.delegate = delegate
        
        audioPlayer?.play()
    }
    
    func stopSound() {
        audioPlayer?.stop()
    }
}

class SoundPlayerDelegate: NSObject, AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Set the number of loops back to -1
        player.numberOfLoops = -1
    }
}
