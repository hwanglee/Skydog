//
//  ShowsList.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct ShowsList: View {
    var shows: [ShowViewModel]
    
    var body: some View {
        List(shows, id: \.show.id) { show in
            NavigationLink {
                SourceView(viewModel: .init(show: show.show))
                    .navigationTitle(show.date)
            } label: {
                HStack(spacing: 14) {
                    Image(uiImage: show.albumArt)
                        .resizable()
                        .clipped()
                        .frame(width: 46, height: 46)
                        .cornerRadius(4)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(show.venueName)
                        Text(show.date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
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
