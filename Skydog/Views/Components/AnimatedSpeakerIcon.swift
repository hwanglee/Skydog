//
//  AnimatedSpeakerIcon.swift
//  Skydog
//
//  Created by Hwang Lee on 3/29/23.
//

import SwiftUI

struct AnimatedSpeakerIcon: View {
    @State private var speakerVariable = 0.25
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Image(systemName: "speaker.wave.3.fill", variableValue: speakerVariable)
            .font(.caption2)
            .onReceive(timer) { _ in
                speakerVariable += 0.25
                speakerVariable = speakerVariable.truncatingRemainder(dividingBy: 1)
                if speakerVariable == 0 { speakerVariable = 0.25 }
            }
    }
}
