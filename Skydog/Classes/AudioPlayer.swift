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
    enum State {
        case idle
        case playing
        case paused
        case loading
    }
    
    /// The track is playing.
    @Published private(set) var state: State = .idle {
        didSet {
            print("did set: \(state)")
        }
    }
    
    @Published var show: ShowViewModel?
    
    /// The current track that the player is playing.
    @Published private(set) var currentTrack: Track? = nil
    
    /// A boolean indicating whether or not there is currently a track loaded.
    @Published var hasTrack: Bool = false
    
    /// The shared audio session.
    let session = AVAudioSession.sharedInstance()
    
    /// The AVPlayer instance that will be used to play audio.
    private(set) var player = AVQueuePlayer()
    
    private var timeControlStatusObserver: AnyCancellable?
    
    /// Initializes an instance of `AudioPlayer`.
    init() {
        setupBindings()
        
        do {
            //            try session.setActive(true)
            try session.setCategory(.playback,
                                    mode: .default,
                                    options: [.allowAirPlay])
            print("Playback OK")
            
            try session.setActive(true)
            
            print("Session is Active")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Loads and starts playing a new track.
    /// - Parameter track: The new track to load.
    func setTrack(track: Track) {
        guard let trackURL = track.url, let url = URL(string: trackURL) else { return }
        
        print("update track: \(track.title)")
        
        currentTrack = track
        
        let playerItem = AVPlayerItem(url: url)
        player.removeAllItems()
        player.insert(playerItem, after: nil)
        
        play()
    }
    
    /// Pauses the player if there is a track loaded.
    func pause() {
        guard currentTrack != nil else { return }
        
        print("pause audio player")
        player.pause()
    }
    
    /// Starts playing the track if there is a track loaded.
    func play() {
        guard currentTrack != nil else { return }
        
        print("play audio player")
        player.play()
    }
    
    /// Toggles the player's playing status.
    func toggle() {
        guard currentTrack != nil else { return }
        
        switch state {
        case .playing:
            pause()
        case .paused:
            play()
        default:
            return
        }
    }
    
    private func setupBindings() {
        $currentTrack
            .map { $0 != nil }
            .assign(to: &$hasTrack)
        
        timeControlStatusObserver = player
            .publisher(for: \.timeControlStatus)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] timeControlStatus in
                switch timeControlStatus {
                case .waitingToPlayAtSpecifiedRate:
                    if self?.state == .idle {
                        self?.state = .loading
                    }
                    
                case .playing:
                    self?.state = .playing
                    
                case .paused:
                    self?.state = .paused
                    
                default:
                    return
                }
            }
    }
}
