//
//  ArtistList.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct ArtistList: View {
    @State var artists = [Artist]()
    @State private var searchText = ""
    @State private var isLoading = false
    
    var searchResults: [Artist] {
        if searchText.isEmpty {
            return artists
        } else {
            return artists.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    ProgressView()
                } else {
                    List(searchResults, id: \.slug) { item in
                        NavigationLink {
                            ArtistView(artist: item)
                        } label: {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(item.name)
                                Text("\(item.showCount) Shows").font(.subheadline).foregroundColor(.gray)
                            }
                        }
                    }
                    .listStyle(.inset)
                    .searchable(text: $searchText)
                }
            }
            .navigationTitle("Artists")
            .disableAutocorrection(true)
        }.task {
            await loadData()
        }
    }
    
    private func loadData() async {
        isLoading = true
        
        do {
            let artists = try await DataLoader.shared.fetchArtists()
            self.artists = artists
            isLoading = false
        } catch {
            print(error.localizedDescription)
            isLoading = false
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistList()
    }
}
