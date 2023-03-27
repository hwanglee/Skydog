//
//  SourcePickerViewModel.swift
//  Skydog
//
//  Created by Hwang Lee on 3/27/23.
//

import Foundation
import Combine

class SourcePickerViewModel: ObservableObject {
    enum SortOption: Int, CaseIterable {
        case ratingHighest
        case ratingLowest
        
        var title: String {
            switch self {
            case .ratingHighest:
                return "Rating (Highest)"
            case .ratingLowest:
                return "Rating (Lowest)"
            }
        }
        
        var imageName: String {
            switch self {
            case .ratingHighest:
                return "arrow.up"
            case .ratingLowest:
                return "arrow.down"
            }
        }
    }
    
    @Published var sortOption: SortOption = .ratingHighest
    @Published var sources: [Source] = []
    
    private var allSources: [Source]
    private var cancellables = Set<AnyCancellable>()
    
    init(sources: [Source]) {
        self.allSources = sources
        
        setUpBindings()
    }
    
    private func setUpBindings() {
        let sortSources: (SortOption) -> Void = { [weak self] option in
            guard let self = self else { return }
            
            switch option {
            case .ratingHighest:
                self.sources = self.allSources.sorted { $0.avgRating > $1.avgRating }
            case .ratingLowest:
                self.sources = self.allSources.sorted { $0.avgRating < $1.avgRating }
            }
        }
        
        $sortOption
            .sink(receiveValue: sortSources)
            .store(in: &cancellables)
    }
    
    deinit { print("Source Picker View Model deinit") }
}
