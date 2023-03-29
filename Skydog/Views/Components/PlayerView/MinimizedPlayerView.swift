//
//  MinimizedPlayerView.swift
//  Skydog
//
//  Created by Hwang Lee on 3/26/23.
//

import SwiftUI

// TODO: Rewrite view logic. For some reason its not observing the player state change.
struct MinimizedPlayerView: View {
    @EnvironmentObject var player: AudioPlayer
    
    var body: some View {
        Group {
            Button(action: {
                print("Previous")
            }) {
                if player.state != .loading {
                    Image(systemName: "backward.fill")
                }
            }
            
            if player.state != .loading {
                PlaybackButton(isPlaying: player.state == .playing) {
                    player.toggle()
                }
                .frame(width: 42, height: 42)
            }
            
            Button(action: {
                print("Next")
            }) {
                if player.state != .loading {
                    Image(systemName: "forward.fill")
                }
            }
        }
        .tint(.primary)
    }
}

struct MinimizedPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let player = AudioPlayer()
        MinimizedPlayerView().environmentObject(player)
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
