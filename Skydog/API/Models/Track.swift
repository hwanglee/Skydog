//
//  Track.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import Foundation

struct Track: Codable {
    var uuid: String
    var url: String?
    var title: String
    var slug: String
    var duration: Int?
    var trackPosition: Int
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case url = "mp3Url"
        case title
        case slug
        case duration
        case trackPosition
    }
}
