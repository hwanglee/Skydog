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
        List(shows, id: \.show.id) { item in
            NavigationLink {
                SourceView(viewModel: .init(showUUID: item.show.uuid))
                    .navigationTitle(item.date)
            } label: {
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.venueName)
                    Text(item.date).font(.subheadline).foregroundColor(.gray)
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
