//
//  SourceViewModel.swift
//  Skydog
//
//  Created by Hwang Lee on 3/17/23.
//

import Foundation

class SourceViewModel {
    var source: Source
    
    init(source: Source) {
        self.source = source
    }
    
    var taper: String {
        (source.taper ?? "").isEmpty ? "N/A" : source.taper!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var transferrer: String {
        (source.transferrer ?? "").isEmpty ? "N/A" : source.transferrer!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
