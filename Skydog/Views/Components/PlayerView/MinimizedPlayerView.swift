//
//  MinimizedPlayerView.swift
//  Skydog
//
//  Created by Hwang Lee on 3/26/23.
//

import SwiftUI

struct MinimizedPlayerView: View {
    @EnvironmentObject var player: AudioPlayer
    
    var body: some View {
        Group {
            Button(action: {
                print("Previous")
            }) {
                Image(systemName: "backward.fill")
            }
            
            Button(action: {
                player.toggle()
            }) {
                Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
            }
            
            Button(action: {
                print("Next")
            }) {
                Image(systemName: "forward.fill")
            }
        }
        .tint(.white)
    }
}

struct MinimizedPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MinimizedPlayerView()
    }
}
