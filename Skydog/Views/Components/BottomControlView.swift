//
//  BottomControlView.swift
//  Skydog
//
//  Created by Hwang Lee on 11/19/22.
//

import SwiftUI

struct BottomControlView: View {
    let imageSize: CGFloat = 28
    @ObservedObject var player = AudioPlayer.instance
    
    var body: some View {
        HStack {
            Image(systemName: "square.fill")
                .font(.system(size: imageSize + 10))
            Text("test")
            
            Spacer()
            
            Image(systemName: "backward.fill")
                .font(.system(size: imageSize))
            
            Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                .font(.system(size: imageSize))
                .onTapGesture {
                    if player.isPlaying {
                        player.pause()
                    } else {
                        player.play()
                    }
                }
            
            Image(systemName: "forward.fill")
                .font(.system(size: imageSize))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.ultraThinMaterial)
    }
}

struct BottomControlView_Previews: PreviewProvider {
    static var previews: some View {
        BottomControlView()
    }
}
