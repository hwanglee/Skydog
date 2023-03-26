//
//  AudioPlayer.swift
//  Skydog
//
//  Created by Hwang Lee on 7/12/22.
//

import Foundation
import AVKit
import Combine

class AudioPlayer: ObservableObject {
    /// The track is playing.
    @Published private(set) var isPlaying = false
    
    /// The current track that the player is playing.
    @Published private(set) var currentTrack: Track? = nil
    
    /// A boolean indicating whether or not there is currently a track loaded.
    @Published var hasTrack: Bool = false
    
    /// Publisher for `hasTrack` property
    private lazy var hasTrackPublisher: Published<Bool>.Publisher = $hasTrack
    
    /// The shared audio session.
    let session = AVAudioSession.sharedInstance()
    
    /// The AVPlayer instance that will be used to play audio.
    private(set) var player = AVPlayer()
    
    /// Initializes an instance of `AudioPlayer`.
    init() {
        $currentTrack
            .map { $0 != nil }
            .assign(to: &$hasTrack)
        
        do {
            try session.setCategory(AVAudioSession.Category.playback,
                                    mode: AVAudioSession.Mode.default,
                                    options: [.allowAirPlay])
            print("Playback OK")
            
            try session.setActive(true)
            
            print("Session is Active")
        } catch {
            print(error)
        }
    }
    
    /// Loads and starts playing a new track.
    /// - Parameter track: The new track to load.
    func setTrack(track: Track) {
        guard let trackURL = track.url, let url = URL(string: trackURL) else { return }
        
        print("update track: \(track.title)")
        
        currentTrack = track
        
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        play()
    }
    
    /// Pauses the player if there is a track loaded.
    func pause() {
        guard currentTrack != nil else { return }
        
        print("pause audio player")
        player.pause()
        isPlaying = false
    }
    
    /// Starts playing the track if there is a track loaded.
    func play() {
        guard currentTrack != nil else { return }
        
        print("play audio player")
        player.play()
        isPlaying = true
    }
    
    /// Toggles the player's playing status.
    func toggle() {
        guard currentTrack != nil else { return }
        
        isPlaying.toggle()
        if isPlaying {
            play()
        } else {
            pause()
        }
    }
}
