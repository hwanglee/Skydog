//
//  VolumeObserver.swift
//  Skydog
//
//  Created by Hwang Lee on 3/26/23.
//

import Foundation
import AVKit
import MediaPlayer

final class VolumeObserver: ObservableObject {
    @Published var volume: Float = AVAudioSession.sharedInstance().outputVolume

    // Audio session object
    private let session = AVAudioSession.sharedInstance()

    // Observer
    private var progressObserver: NSKeyValueObservation!

    func subscribe() {
        progressObserver = session.observe(\.outputVolume) { [self] (session, value) in
            DispatchQueue.main.async {
                self.volume = session.outputVolume
            }
        }
    }
    
    func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView(frame: .zero)
        volumeView.alpha = 0.001
        volumeView.isHidden = true
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }

    func unsubscribe() {
        self.progressObserver.invalidate()
    }

    init() {
        subscribe()
    }
    
    deinit {
        unsubscribe()
    }
}
