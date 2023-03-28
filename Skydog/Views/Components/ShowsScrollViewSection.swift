//
//  ShowsScrollViewSection.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct ShowsScrollViewSection: View {
    var shows: [ShowViewModel] = []
    var title: String
    
    var body: some View {
        Section {
            HorizontalScrollView {
                ForEach(shows.prefix(10), id: \.show.id) { item in
                    NavigationLink {
                        SourceView(viewModel: .init(show: item.show))
                            .navigationTitle(item.date)
                    } label: {
                        AlbumCell(
                            venue: item.venueName,
                            date: item.date,
                            image: item.albumArt
                        )
                    }
                }
            }
        } header: {
            NavigationLink {
                ShowsList(shows: shows)
                    .navigationTitle(title)
            } label: {
                ScrollViewHeader(title: title)
            }
        }
        .buttonStyle(.plain)
    }
}

struct ShowsScrollViewSection_Previews: PreviewProvider {
    static var previews: some View {
        ShowsScrollViewSection(shows: [.init(show: .example)], title: "test")
    }
}
