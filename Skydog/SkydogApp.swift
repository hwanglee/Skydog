//
//  SkydogApp.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

@main
struct SkydogApp: App {
    @StateObject var audioPlayer = AudioPlayer()
    
    var body: some Scene {
        WindowGroup {
            BaseView()
                .environmentObject(audioPlayer)
                .tint(.teal)
        }
    }
}
