//
//  ShowListItemViewModel.swift
//  Skydog
//
//  Created by Hwang Lee on 3/17/23.
//

import Foundation
import UIKit.UIImage

class ShowViewModel {
    private(set) var show: Show
    
    private(set) lazy var albumArt = createAlbumArt()
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: show.displayDate)
        
        guard let date = date else { return show.displayDate }
        
        return date.formatted(date: .numeric, time: .omitted)
    }
    
    var venueName: String { show.venue?.name ?? "Unknown Venue" }
    
    var averageRatingLabel: String {
        return "Rating: \(show.avgRating.formatted(.number.precision(.fractionLength(1))))"
    }
    
    init(show: Show) {
        self.show = show
    }
    
    private func createAlbumArt() -> UIImage {
        let imageIndex = venueName.count % 18
        let image = UIImage(named: "\(imageIndex)")
        let color = (venueName + show.displayDate).generateColor().withAlphaComponent(0.1)
        let albumArt = image?.tint(tintColor: color).writeText(text: venueName, textPosition: .left)
        
        return albumArt ?? UIImage()
    }
}
