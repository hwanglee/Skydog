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
    @State var background = Int.random(in: 0...5)
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        GeometryReader { geometry in
            return VStack {
                Image("\(background)")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .aspectRatio(contentMode: .fit)
                    .padding([.leading, .trailing], 10)
                    .padding([.top], geometry.size.height * 60 / screenHeight)
                    .shadow(radius: 5)
                
                VStack(spacing: geometry.size.height * 30.0 / screenHeight) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(player.currentTrack?.title ?? "")
                                .font(.system(size: 20, weight: .bold))
                        }
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
                Image("\(background)").resizable()
                .edgesIgnoringSafeArea(.all)
                .allowsHitTesting(false)
                .blur(radius: 100)
            }
        }
        .tint(.primary)
        .popupTitle(player.currentTrack?.title ?? "")
        .popupImage(Image("\(background)").resizable())
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
