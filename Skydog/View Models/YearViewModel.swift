//
//  YearViewModel.swift
//  Skydog
//
//  Created by Hwang Lee on 3/29/23.
//

import Foundation

class YearViewModel: LoadableObject {
    typealias Output = [Show]
    
    @Published var state: LoadingState<[Show]> = .idle
    @Published var shows: [Show] = []
    
    private(set) var year: Year
    
    init(year: Year) {
        self.year = year
    }
    
    func load() async {
        state = .loading
        
        do {
            self.shows = try await DataLoader.shared.fetchShows(artistSlug: year.artistUuid,
                                                                year: year.year)
            
            state = .loaded(self.shows)
        } catch {
            state = .failed(error)
        }
    }
}
