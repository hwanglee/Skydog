//
//  Source.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import Foundation

struct Source: Decodable {
    var reviewCount: Int
    var description: String
    var avgRating: Float
    var duration: Int
    var sets: [SourceSet]
    var uuid: String
    var isSoundboard: Bool
    var isRemaster: Bool
    var source: String?
    var transferrer: String?
    var taper: String?
    
    var formattedTaper: String {
        (taper ?? "").isEmpty ? "N/A" : taper!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var formattedTransferrer: String {
        (transferrer ?? "").isEmpty ? "N/A" : transferrer!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
