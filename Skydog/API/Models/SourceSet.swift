//
//  SourceSet.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import Foundation

struct SourceSet: Decodable {
    var tracks: [Track]
    var isEncore: Bool
    var index: Int
    var uuid: String
}
