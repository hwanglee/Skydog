//
//  PlayerView.swift
//  Skydog
//
//  Created by Hwang Lee on 3/26/23.
//

import SwiftUI
import LNPopupUI
import LNPopupController
import Combine

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
    @State var volume: Float = Float.random(in: 0..<1)
    @EnvironmentObject var player: AudioPlayer
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        GeometryReader { geometry in
            return VStack {
                Image("Backgrounds/0")
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
                        .font(.system(size: 50, weight: .bold))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                        Button(action: {}, label: {
                            Image(systemName: "forward.fill")
                        })
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .font(.system(size: 30, weight: .regular))
                    .padding([.bottom], geometry.size.height * 20.0 / screenHeight)
                    HStack {
                        Image(systemName: "speaker.fill")
                        Slider(value: $volume)
                        Image(systemName: "speaker.wave.2.fill")
                    }
                    .font(.footnote)
                    .foregroundColor(.gray)
                    HStack {
                        Button(action: {}, label: {
                            Image(systemName: "shuffle")
                        })
                        .frame(minWidth: 0, maxWidth: .infinity)
                        Button(action: {}, label: {
                            Image(systemName: "airplayaudio")
                        })
                        .frame(minWidth: 0, maxWidth: .infinity)
                        Button(action: {}, label: {
                            Image(systemName: "repeat")
                        })
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .font(.body)
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
                    Image("Backgrounds/0")
                        .resizable()
                    BlurView()
                }
                .edgesIgnoringSafeArea(.all)
            }())
        }
        .tint(.white)
        .popupTitle(player.currentTrack?.title ?? "")
        .popupImage(Image("Backgrounds/0").resizable())
        .popupProgress(playbackProgress)
        .popupBarItems({
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
        })
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
