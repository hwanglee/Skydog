//
//  SoundboardBadge.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct SoundboardBadge: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(.blue)
            .frame(width: 34, height: 20)
            .overlay(
                Text("SBD")
                    .foregroundColor(.white)
                    .font(.caption2)
                    .fontWeight(.medium)
            )
    }
}

struct SoundboardBadge_Previews: PreviewProvider {
    static var previews: some View {
        SoundboardBadge()
    }
}
