//
//  ShowsScrollViewSection.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct ShowsScrollViewSection: View {
    var shows: [Show] = []
    var title: String
    
    var body: some View {
        Section {
            HorizontalScrollView {
                ForEach(shows.prefix(10), id: \.id) { item in
                    NavigationLink {
                        SourceView(show: item)
                    } label: {
                        AlbumCell(
                            venue: item.venue?.name ?? "",
                            date: item.displayDate,
                            image: item.albumArt
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        } header: {
            NavigationLink {
                ShowsList(shows: shows)
                    .navigationTitle(title)
            } label: {
                ScrollViewHeader(title: title)
            }
            .buttonStyle(.plain)
        }
    }
}

struct ShowsScrollViewSection_Previews: PreviewProvider {
    static var previews: some View {
        ShowsScrollViewSection(shows: [], title: "test")
    }
}
