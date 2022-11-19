//
//  AudioPlayer.swift
//  Skydog
//
//  Created by Hwang Lee on 7/12/22.
//

import Foundation
import AVKit

class AudioPlayer: ObservableObject {
    public static var instance = AudioPlayer()
    
    @Published private(set) var isPlaying = false
    private(set) var player = AVPlayer()
    
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback,
                                                            mode: AVAudioSession.Mode.default,
                                                            options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
    }
    
    func setSource(url: String) {
        guard let url = URL(string: url) else { return }
        
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        play()
    }
    
    func pause() {
        print("pause audio player")
        player.pause()
        isPlaying = false
    }
    
    func play() {
        print("play audio player")
        player.play()
        isPlaying = true
    }
}
