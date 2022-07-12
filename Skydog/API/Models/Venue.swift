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
