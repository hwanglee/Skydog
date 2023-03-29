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
                SourceView(
                    viewModel: .init(show: show.show),
                    albumArt: show.albumArt
                )
                    .navigationTitle(show.date)
            } label: {
                HStack(spacing: 14) {
                    Image(uiImage: show.albumArt)
                        .resizable()
                        .clipped()
                        .frame(width: 60, height: 60)
                        .cornerRadius(4)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(show.venueName)
                            .lineLimit(1)
                        
                        Text(show.date)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(show.averageRatingLabel)
                            .font(.footnote)
                            .foregroundColor(.secondary)
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
