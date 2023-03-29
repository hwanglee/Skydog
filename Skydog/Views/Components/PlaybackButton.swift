//
//  PlaybackButton.swift
//  Skydog
//
//  Created by Hwang Lee on 3/27/23.
//

import SwiftUI

struct PlaybackButton: View {
    var isPlaying: Bool
    var action: () -> ()
    @State private var transparency: Double = 0.0
    
    var body: some View {
        Button {
            action()
            transparency = 0.6
            withAnimation(.easeOut(duration: 0.2)) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    transparency = 0.0
                }
            }
        } label: {
            ZStack {
                Circle()
                    .opacity(transparency)
                
                Image(systemName: "pause.fill")
                    .scaleEffect(isPlaying ? 1 : 0)
                    .opacity(isPlaying ? 1 : 0)
                    .animation(.interpolatingSpring(stiffness: 170, damping: 15), value: isPlaying)
                
                Image(systemName: "play.fill")
                    .scaleEffect(isPlaying ? 0 : 1)
                    .opacity(isPlaying ? 0 : 1)
                    .animation(.interpolatingSpring(stiffness: 170, damping: 15), value: isPlaying)
            }
        }
    }
}

struct PlaybackButton_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackButton(isPlaying: true) {
            print("test")
        }
        .preferredColorScheme(.dark)
    }
}
