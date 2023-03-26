//
//  PlayerView.swift
//  Skydog
//
//  Created by Hwang Lee on 3/26/23.
//

import SwiftUI
import LNPopupUI
import LNPopupController

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct PlayerView: View {
    @State var playbackProgress: Float = Float.random(in: 0..<1)
    @EnvironmentObject var player: AudioPlayer
    private let screenHeight = UIScreen.main.bounds.height
    @State var background = Int.random(in: 0...5)
    
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
                    PlayerControls()
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
            .background({
                ZStack {
                    Image("\(background)").resizable()
                    BlurView()
                }
                .edgesIgnoringSafeArea(.all)
                .allowsHitTesting(false)
            }())
        }
        .tint(.white)
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
