//
//  BaseView.swift
//  Skydog
//
//  Created by Hwang Lee on 3/26/23.
//

import SwiftUI
import LNPopupUI
import Combine

struct BaseView: View {
    @StateObject var player = AudioPlayer()
    
    var body: some View {
        TabView {
            ArtistList(viewModel: .init())
                .tabItem {
                    Text("Artists")
                    Image(systemName: "person.fill")
                }
            
            ArtistList(viewModel: .init())
                .tabItem {
                    Text("Library")
                    Image(systemName: "square.stack.fill")
                }
        }
        .environmentObject(player)
        // https://stackoverflow.com/a/70867370/21492313
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .popup(isBarPresented: $player.hasTrack) {
            PlayerView()
        }
        .popupBarMarqueeScrollEnabled(true)
        .popupInteractionStyle(.customizedSnap(percent: 0.25))
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView().environmentObject(AudioPlayer())
    }
}
