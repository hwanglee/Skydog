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
            MarqueeText(
                text: player.currentTrack?.title ?? "",
                font: UIFont.preferredFont(forTextStyle: .title3),
                leftFade: 0,
                rightFade: 0,
                startDelay: 1.5
            )
            .lineLimit(1)
            
            Spacer()
            
            Button {
            } label: {
                Image(systemName: "backward.fill")
                    .font(.system(size: imageSize))
            }
            .tint(Color(UIColor.label))
            
            Button {
                if player.isPlaying {
                    player.pause()
                } else {
                    player.play()
                }
            } label: {
                Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: imageSize))
            }
            .tint(Color(UIColor.label))
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
            
            Button {
            } label: {
                Image(systemName: "forward.fill")
                    .font(.system(size: imageSize))
            }
            .tint(Color(UIColor.label))
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
