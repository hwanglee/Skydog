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
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image(uiImage: player.albumArt)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .aspectRatio(contentMode: .fit)
                    .padding([.leading, .trailing], 10)
                    .padding([.top], geometry.size.height * 0.08)
                    .shadow(radius: 5)
                
                VStack(spacing: 0) {
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
                    .padding(.bottom, 20)
                    
                    ProgressView(value: playbackProgress)
                        .padding(.bottom, 10)
                    
                    Group {
                        if player.state == .loading {
                            ProgressView()
                        } else {
                            PlayerControls()
                        }
                    }
                    .frame(maxHeight: .infinity)
                    
                    VolumeSliderView()
                    
                    BottomButtons()
                        .frame(maxHeight: .infinity)
//                        .frame(height: 40)
                }
                .padding([.leading, .trailing], geometry.size.width * 0.1)
                .padding(.top, geometry.size.height * 0.1)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .top
            )
            .background {
                ZStack {
                    Image(uiImage: player.albumArt).resizable()
                        .allowsHitTesting(false)
                    
                    Rectangle()
                        .background(.ultraThinMaterial, in: Rectangle())
                        .environment(\.colorScheme, .light)
                }
                .edgesIgnoringSafeArea(.all)
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
            MinimizedPlayerView(isLoading: player.state == .loading)
        })
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
