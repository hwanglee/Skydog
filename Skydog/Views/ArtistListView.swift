//
//  SwiftUIView.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct ArtistListView: View {
    @State var artists = [Artist]()
    @State private var searchText = ""
    
    var searchResults: [Artist] {
        if searchText.isEmpty {
            return artists
        } else {
            return artists.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List(searchResults, id: \.slug) { item in
                NavigationLink {
                    ArtistView(artist: item)
                } label: {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(item.name)
                        Text(item.slug).font(.subheadline).foregroundColor(.gray)
                    }
                }
            }
            .listStyle(.inset)
            .searchable(text: $searchText)
            .navigationTitle("Artists")
            .disableAutocorrection(true)
        }.task {
            await loadData()
        }
    }
    
    private func loadData() async {
        do {
            let artists = try await DataLoader.shared.fetchArtists()
            self.artists = artists
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistListView()
    }
}
