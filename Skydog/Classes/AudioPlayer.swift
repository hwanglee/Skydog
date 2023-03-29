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
    
    var albumArt: UIImage { show?.albumArt ?? UIImage() }
    var currentTrackName: String? { currentTrack?.title }
    
//    @Published var currentTime: CMTime = .zero
//
//    var currentTimeString: String { currentTime.toString() }
//
//    var duration: CMTime? { player.currentItem?.duration }
//    var durationString: String { duration?.toString() ?? "" }
    
    /// The shared audio session.
    let session = AVAudioSession.sharedInstance()
    
    /// The AVPlayer instance that will be used to play audio.
    private(set) var player = AVQueuePlayer()
    
    private var cancellables = Set<AnyCancellable>()
    
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
        player.pause()
    }
    
    /// Starts playing the track if there is a track loaded.
    func play() {
        player.play()
    }
    
    /// Toggles the player's playing status.
    func toggle() {
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
        
        player
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
            .store(in: &cancellables)
        
//        player
//            .periodicTimePublisher()
//            .receive(on: DispatchQueue.main)
//            .sink {
//                self.currentTime = $0
//            }
//            .store(in: &cancellables)
    }
}

extension AVPlayer {
    func periodicTimePublisher(forInterval interval: CMTime = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))) -> AnyPublisher<CMTime, Never> {
        Publisher(self, forInterval: interval)
            .eraseToAnyPublisher()
    }
}

fileprivate extension AVPlayer {
    private struct Publisher: Combine.Publisher {
    
        typealias Output = CMTime
        typealias Failure = Never
    
        var player: AVPlayer
        var interval: CMTime

        init(_ player: AVPlayer, forInterval interval: CMTime) {
            self.player = player
            self.interval = interval
        }

        func receive<S>(subscriber: S) where S : Subscriber, Publisher.Failure == S.Failure, Publisher.Output == S.Input {
            let subscription = CMTime.Subscription(subscriber: subscriber, player: player, forInterval: interval)
            subscriber.receive(subscription: subscription)
        }
    }
}

fileprivate extension CMTime {
    final class Subscription<SubscriberType: Subscriber>: Combine.Subscription where SubscriberType.Input == CMTime, SubscriberType.Failure == Never {

        var player: AVPlayer? = nil
        var observer: Any? = nil

        init(subscriber: SubscriberType, player: AVPlayer, forInterval interval: CMTime) {
            self.player = player
            observer = player.addPeriodicTimeObserver(forInterval: interval, queue: nil) { time in
                _ = subscriber.receive(time)
            }
        }

        func request(_ demand: Subscribers.Demand) {
            // We do nothing here as we only want to send events when they occur.
            // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
        }

        func cancel() {
            if let observer = observer {
                player?.removeTimeObserver(observer)
            }
            observer = nil
            player = nil
        }
    }
    
    func toString() -> String {
        let cmSeconds = CMTimeGetSeconds(self)
        
        guard seconds != .infinity, !cmSeconds.isNaN else { return "00:00" }
        
        let totalSeconds = Int(cmSeconds)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
