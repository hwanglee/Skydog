//
//  Venue.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import Foundation

struct Venue: Decodable {
    var id: Int
    var name: String
    var slug: String
    var uuid: String
    var sortName: String
}

extension Venue {
    static var example: Venue {
        return .init(id: 0, name: "Warner Theater", slug: "warner-theater", uuid: "uuid", sortName: "Warner Theater")
    }
}
