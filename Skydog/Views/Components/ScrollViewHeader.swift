//
//  ScrollViewHeader.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct ScrollViewHeader: View {
    var title: String
    
    var body: some View {
        HStack() {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading, 10)
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

struct ScrollViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewHeader(title: "Test")
    }
}
