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
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "backward.fill")
                })
                .frame(minWidth: 0, maxWidth: .infinity)
                
                Button(action: {
                    player.toggle()
                }, label: {
                    Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                })
                .font(.system(size: 40, weight: .bold))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                
                Button(action: {}, label: {
                    Image(systemName: "forward.fill")
                })
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .font(.system(.title))
        }
    }
}

struct PlayerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControls()
    }
}
