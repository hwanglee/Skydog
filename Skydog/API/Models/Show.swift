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
    
    var albumArt: UIImage {
        print(uuid)
        let imageIndex = (venue?.name.count ?? 0) % 18
        let image = UIImage(named: "Backgrounds/\(imageIndex)")
        
        return image ?? UIImage()
    }
}
