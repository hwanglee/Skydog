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
    @Published private(set) var currentTrack: Track? = nil
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
    
    func setTrack(track: Track) {
        guard let trackURL = track.url, let url = URL(string: trackURL) else { return }
        
        print("update track: \(track.title)")
        
        currentTrack = track
        
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        play()
    }
    
    func pause() {
        guard currentTrack != nil else { return }
        
        print("pause audio player")
        player.pause()
        isPlaying = false
    }
    
    func play() {
        guard currentTrack != nil else { return }
        
        print("play audio player")
        player.play()
        isPlaying = true
    }
}
