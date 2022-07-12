//
//  Show.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import Foundation

struct Show: Decodable {
    var id: Int
    var displayDate: String
    var venue: Venue?
    var avgRating: Float
    var uuid: String
}
