//
//  PlayerView.swift
//  Skydog
//
//  Created by Hwang Lee on 3/26/23.
//

import SwiftUI
import LNPopupUI
import LNPopupController

struct PlayerView: View {
    @EnvironmentObject var player: AudioPlayer
    @State var playbackProgress: Float = Float.random(in: 0..<1)
    @Environment(\.colorScheme) var colorScheme
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        GeometryReader { geometry in
            return VStack {
                Image(uiImage: player.albumArt)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .aspectRatio(contentMode: .fit)
                    .padding([.leading, .trailing], 10)
                    .padding([.top], geometry.size.height * 60 / screenHeight)
                    .shadow(radius: 5)
                
                VStack(spacing: geometry.size.height * 30.0 / screenHeight) {
                    HStack {
                        Text(player.currentTrackName ?? "")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .frame(minWidth: 0,
                                   maxWidth: .infinity,
                                   alignment: .topLeading)
                        Button(action: {}, label: {
                            Image(systemName: "ellipsis.circle")
                                .font(.title)
                        })
                    }
                    
                    ProgressView(value: playbackProgress)
                        .padding([.bottom], geometry.size.height * 30.0 / screenHeight)

                    if player.state == .loading {
                        ProgressView()
                            .frame(width: 60, height: 60)
                    } else {
                        PlayerControls()
                        Spacer()
                    }
                    
                    VolumeSliderView()
                    BottomButtons()
                }
                .padding(geometry.size.height * 40.0 / UIScreen.main.bounds.height)
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: .infinity,
                   alignment: .top)
            .background {
                ZStack {
                    Image(uiImage: player.albumArt).resizable()
                        .edgesIgnoringSafeArea(.all)
                        .allowsHitTesting(false)
                    
                    Rectangle()
                        .background(.ultraThinMaterial, in: Rectangle())
                        .environment(\.colorScheme, .light)
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }
        .tint(.white)
        .popupTitle(player.currentTrackName ?? "")
        .popupImage(
            Image(
                uiImage: player.albumArt.preparingThumbnail(of: .init(width: 150, height: 150)) ?? UIImage()
            )
            .resizable()
        )
        .popupBarItems({
            MinimizedPlayerView()
        })
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
