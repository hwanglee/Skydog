//
//  SkydogApp.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

@main
struct SkydogApp: App {
    let audioPlayer = AudioPlayer()
    
    var body: some Scene {
        WindowGroup {
            ArtistListView().environmentObject(audioPlayer)
            BottomControlView().environmentObject(audioPlayer)
        }
    }
}
