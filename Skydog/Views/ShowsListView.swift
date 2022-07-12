//
//  ShowsListView.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct ShowsListView: View {
    var shows: [Show]
    
    var body: some View {
        List(shows, id: \.id) { item in
            NavigationLink {
                SourceView(show: item)
            } label: {
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.venue?.name ?? "")
                    Text(item.displayDate).font(.subheadline).foregroundColor(.gray)
                }
            }
        }
        .listStyle(.inset)
        .onAppear {
            print(shows)
        }
    }
}

//struct ShowsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowsListView()
//    }
//}
