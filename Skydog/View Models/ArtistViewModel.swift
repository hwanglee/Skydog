//
//  ArtistViewModel.swift
//  Skydog
//
//  Created by Hwang Lee on 3/29/23.
//

import Foundation

class ArtistViewModel: LoadableObject {
    typealias Output = [Year]
    
    @Published var state: LoadingState<[Year]> = .idle
    @Published var years: [Year] = []
    @Published var topShows: [Show] = []
    @Published var recentShows: [Show] = []
    
    private(set) var artist: Artist
    
    init(artist: Artist) {
        self.artist = artist
    }
    
    @MainActor
    func load() async {
        state = .loading
        
        do {
            async let topShows = DataLoader.shared.fetchTopShows(artistSlug: artist.slug)
            async let recentShows = DataLoader.shared.fetchRecentShows(artistSlug: artist.slug)
            async let years = DataLoader.shared.fetchYears(artistSlug: artist.slug)
            
            self.topShows = try await topShows
            self.recentShows = try await recentShows
            self.years = try await years.sorted { $0.year > $1.year }
            
            state = .loaded(self.years)
        } catch {
            state = .failed(error)
            
            switch error {
            case DecodingError.dataCorrupted(let context):
                print(context)
            case DecodingError.keyNotFound(let key, let context):
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case DecodingError.valueNotFound(let value, let context):
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case DecodingError.typeMismatch(let type, let context):
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            default:
                print("error: ", error)
            }
        }
    }
}
