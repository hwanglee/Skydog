//
//  VolumeSliderView:.swift
//  Skydog
//
//  Created by Hwang Lee on 3/26/23.
//

import SwiftUI

struct VolumeSliderView: View {
    @ObservedObject private var volObserver = VolumeObserver()
    @State private var test = 0.0
    
    var body: some View {
        VolumeSlider(
            value: $volObserver.volume,
            inRange: 0...1,
            activeFillColor: .white,
            fillColor: .white,
            emptyColor: .secondary,
            height: 8) {
                volObserver.setVolume($0)
            }
        .frame(height: 30)
    }
}

struct SpeakerControlView_Previews: PreviewProvider {
    static var previews: some View {
        VolumeSliderView()
    }
}
