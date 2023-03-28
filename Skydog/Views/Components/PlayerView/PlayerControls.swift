//
//  PlayerControls.swift
//  Skydog
//
//  Created by Hwang Lee on 3/26/23.
//

import SwiftUI

struct PlayerControls: View {
    @EnvironmentObject var player: AudioPlayer
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: geometry.size.width / 6) {
                Button(action: {}, label: {
                    Image(systemName: "backward.fill")
                })
                
                FluidMusicButons(isPlaying: player.state == .playing) {
                    player.toggle()
                }
                .font(.system(size: 42))
                .frame(width: 66, height: 66)
                
                Button(action: {}, label: {
                    Image(systemName: "forward.fill")
                })
            }
            .font(.system(.title))
            .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

struct PlayerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControls()
    }
}
