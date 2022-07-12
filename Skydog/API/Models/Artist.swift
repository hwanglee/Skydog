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
}
