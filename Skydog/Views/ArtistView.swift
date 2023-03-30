//
//  ArtistView.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct ArtistView: View {
    @StateObject var viewModel: ArtistViewModel
    
    var sectionSpacing: CGFloat = 20
    
    var body: some View {
        let _ = Self._printChanges()
        AsyncContentView(source: viewModel) { _ in
            ScrollView(.vertical) {
                VStack(spacing: sectionSpacing) {
                    ShowsScrollViewSection(
                        shows: viewModel.topShows.map { ShowViewModel(show: $0) },
                        title: "Top Shows"
                    )
                    
                    ShowsScrollViewSection(
                        shows: viewModel.recentShows.map { ShowViewModel(show: $0) },
                        title: "Recent Shows"
                    )
                    
                    Section {
                        HorizontalScrollView {
                            ForEach(viewModel.years.prefix(10), id: \.id) { year in
                                NavigationLink {
                                    YearView(viewModel: .init(year: year))
                                } label: {
                                    YearCell(year: year.year)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    } header: {
                        NavigationLink {
                            YearList(years: viewModel.years)
                        } label: {
                            ScrollViewHeader(title: "Years")
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.top, 20)
            }
        }
        .navigationTitle(viewModel.artist.name)
    }
}

struct ArtistView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistView(viewModel: .init(artist: .example))
    }
}
