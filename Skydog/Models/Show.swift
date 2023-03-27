//
//  Show.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import Foundation
import UIKit

struct Show: Decodable {
    var id: Int
    var displayDate: String
    var venue: Venue?
    var avgRating: Float
    var uuid: String
}

extension Show {
    static var example: Show {
        return Show(id: 0, displayDate: "12/22/2022", venue: .example, avgRating: 9.0, uuid: "test")
    }
}
