//
//  ShowsList.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct ShowsList: View {
    var shows: [ShowListItemViewModel]
    
    var body: some View {
        List(shows, id: \.show.id) { show in
            NavigationLink {
                SourceView(viewModel: .init(showUUID: show.show.uuid))
                    .navigationTitle(show.date)
            } label: {
                HStack(spacing: 10) {
                    Image(uiImage: show.albumArt)
                        .resizable()
                        .clipped()
                        .frame(width: 40, height: 40)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(show.venueName)
                        Text(show.date).font(.subheadline).foregroundColor(.gray)
                    }
                }
            }
        }
        .listStyle(.inset)
    }
}

struct ShowsListView_Previews: PreviewProvider {
    static var previews: some View {
        ShowsList(shows: [.init(show: .example)])
    }
}
