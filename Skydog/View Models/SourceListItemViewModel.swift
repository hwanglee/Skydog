//
//  SourceListItemViewModel.swift
//  Skydog
//
//  Created by Hwang Lee on 3/27/23.
//

import Foundation

class SourceListItemViewModel: ObservableObject {
    private var source: Source
    
    var formattedTaper: String { formatted(source.taper) }
    
    var formattedTransferrer: String { formatted(source.transferrer) }
    
    var averageRating: Double { source.avgRating }
    
    var isSoundboard: Bool { source.isSoundboard }
    
    var isRemaster: Bool { source.isRemaster }
    
    init(source: Source) {
        self.source = source
    }
    
    private func formatted(_ str: String?) -> String {
        guard let str = str, !str.isEmpty else { return "N/A" }
        
        return str.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
