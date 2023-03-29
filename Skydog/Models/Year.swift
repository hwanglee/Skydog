//
//  Year.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import Foundation

struct Year: Decodable {
    var id: Int
    var year: String
    var uuid: String
    var artistId: Int
    var artistUuid: String
    var showCount: Int
}

extension Year {
    static var example: Year {
        return .init(id: 0, year: "2023", uuid: "uuid", artistId: 1, artistUuid: "test", showCount: 10)
    }
}
