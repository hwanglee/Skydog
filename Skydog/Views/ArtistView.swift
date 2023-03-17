//
//  ArtistView.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct ArtistView: View {
    var artist: Artist
    @State private var topShows = [Show]()
    @State private var recentShows = [Show]()
    @State private var years = [Year]()
    
    var sectionSpacing: CGFloat = 20
    
    var body: some View {
        ScrollView(.vertical) {
            Spacer(minLength: sectionSpacing)
            
            ShowsScrollViewSection(shows: topShows, title: "Top Shows")
            
            Spacer(minLength: sectionSpacing)
            
            ShowsScrollViewSection(shows: recentShows, title: "Recent Shows")
            
            Spacer(minLength: sectionSpacing)
            
            Section {
                HorizontalScrollView {
                    ForEach(years.prefix(10), id: \.id) { item in
                        NavigationLink {
                            YearView(year: item)
                        } label: {
                            YearCell(year: item.year)
                        }
                        .buttonStyle(.plain)
                    }
                }
            } header: {
                NavigationLink {
                    YearListView(years: years)
                } label: {
                    ScrollViewHeader(title: "Years")
                }
                .buttonStyle(.plain)
            }
        }
        .task {
            await loadData()
        }
        .navigationTitle(artist.name)
    }
    
    private func loadData() async {
        do {
            async let shows = DataLoader.shared.fetchShows(artistSlug: artist.slug)
            async let recentShows = DataLoader.shared.fetchRecentShows(artistSlug: artist.slug)
            async let years = DataLoader.shared.fetchYears(artistSlug: artist.slug)
            
            self.topShows = try await shows
            self.recentShows = try await recentShows
            self.years = try await years.sorted { $0.year > $1.year }
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
    }
}

//struct ArtistView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArtistView()
//    }
//}
