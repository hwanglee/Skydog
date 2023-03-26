//
//  Artist.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import Foundation

struct Artist: Decodable {
    var name: String
    var slug: String
    var uuid: String
    var musicbrainzId: String
    var showCount: Int
}

extension Artist {
    static var example: Artist {
        return .init(name: "Herbie Hancock", slug: "herbie-hancock", uuid: "uuid", musicbrainzId: "0", showCount: 12)
    }
}
