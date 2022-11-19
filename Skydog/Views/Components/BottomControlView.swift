//
//  BottomControlView.swift
//  Skydog
//
//  Created by Hwang Lee on 11/19/22.
//

import SwiftUI

struct BottomControlView: View {
    let imageSize: CGFloat = 28
    
    var body: some View {
        HStack {
            Image(systemName: "square.fill")
                .font(.system(size: imageSize + 10))
            Text("test")
            
            Spacer()
            
            Image(systemName: "backward.fill")
                .font(.system(size: imageSize))
            
            Image(systemName: "play.fill")
                .font(.system(size: imageSize))
            
            Image(systemName: "forward.fill")
                .font(.system(size: imageSize))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.red)
    }
}

struct BottomControlView_Previews: PreviewProvider {
    static var previews: some View {
        BottomControlView()
    }
}
