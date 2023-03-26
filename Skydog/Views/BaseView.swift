//
//  BaseView.swift
//  Skydog
//
//  Created by Hwang Lee on 3/26/23.
//

import SwiftUI
import LNPopupUI

struct BaseView: View {
    @State var isPopupBarPresented = true
    @State var isPopupOpen = false
    
    var body: some View {
        ArtistListView()
            .popup(isBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen) {
                PlayerView()
            }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
