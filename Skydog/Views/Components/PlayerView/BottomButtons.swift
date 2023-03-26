//
//  BottomButtons.swift
//  Skydog
//
//  Created by Hwang Lee on 3/26/23.
//

import SwiftUI

struct BottomButtons: View {
    var body: some View {
        HStack {
            Button(action: {}, label: {
                Image(systemName: "shuffle")
                    .resizable()
                    .frame(width: 20, height: 20)
            })
            .frame(minWidth: 0, maxWidth: .infinity)
            
            AirPlayButton()
                .frame(minWidth: 0, maxWidth: .infinity)
            
            Button(action: {}, label: {
                Image(systemName: "repeat")
                    .resizable()
                    .frame(width: 20, height: 20)
            })
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        .font(.body)
    }
}

struct BottomButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        BottomButtons()
    }
}
