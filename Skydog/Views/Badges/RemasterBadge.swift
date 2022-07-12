//
//  RemasterBadge.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct RemasterBadge: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(.teal)
            .frame(width: 60, height: 20)
            .overlay(
                Text("Remaster")
                    .foregroundColor(.white)
                    .font(.caption2)
                    .fontWeight(.medium)
            )
    }
}

struct RemasterBadge_Previews: PreviewProvider {
    static var previews: some View {
        RemasterBadge()
    }
}
