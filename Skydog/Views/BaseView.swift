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
    @EnvironmentObject var player: AudioPlayer
    @State var isPopupBarPresented  = false
    @State var isPopupOpen = false
    
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
        // https://stackoverflow.com/a/70867370/21492313
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .tint(.white)
        .popup(isBarPresented: $player.hasTrack, isPopupOpen: $isPopupOpen) {
            PlayerView()
        }
        .popupBarMarqueeScrollEnabled(true)
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
