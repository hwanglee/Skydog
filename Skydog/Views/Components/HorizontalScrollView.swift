//
//  HorizontalScrollView.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct HorizontalScrollView<Content: View>: View {
    let content: Content
    
    private let itemSpacing: CGFloat = 10
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem()], alignment: .top, spacing: itemSpacing) {
                self.content
            }
            .padding(itemSpacing)
        }
    }
}

struct HorizontalScrollView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalScrollView {
            ForEach(0...5, id: \.self) { _ in
                Rectangle()
            }
        }
    }
}
