//
//  ArtistListViewModel.swift
//  Skydog
//
//  Created by Hwang Lee on 3/26/23.
//

import Foundation

class ArtistListViewModel: LoadableObject {
    typealias Output = [Artist]
    
    @Published var state: LoadingState<[Artist]> = .idle
    @Published var searchQuery = ""
    @Published private var artists: [Artist] = []
    
    var filteredArtists: [Artist] {
        if searchQuery.isEmpty {
            return artists
        } else {
            return artists.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
        }
    }
    
    @MainActor
    func load() async {
        state = .loading
        
        do {
            artists = try await DataLoader.shared.fetchArtists()
            state = .loaded(artists)
        } catch {
            print(error)
            state = .failed(error)
        }
    }
}
