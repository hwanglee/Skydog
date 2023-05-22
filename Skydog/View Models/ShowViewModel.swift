//
//  ShowListItemViewModel.swift
//  Skydog
//
//  Created by Hwang Lee on 3/17/23.
//

import Foundation
import UIKit.UIImage

class ShowViewModel: ObservableObject {
    @Published var albumArt = UIImage()
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: show.displayDate)
        
        guard let date = date else { return show.displayDate }
        
        return date.formatted(date: .long, time: .omitted)
    }
    
    var venueName: String { show.venue?.name ?? "Unknown Venue" }
    
    var averageRating: Double { show.avgRating }
    
    private(set) var show: Show
    
    init(show: Show) {
        self.show = show
        
        createAlbumArt()
    }
    
    private func createAlbumArt() {
        let imageIndex = venueName.count % 18
        let image = UIImage(named: "\(imageIndex)")
        let color = (venueName + show.displayDate).generateColor().withAlphaComponent(0.1)
        let albumArt = image?.tint(tintColor: color).writeText(text: venueName, textPosition: .left)
        
        self.albumArt = albumArt ?? UIImage()
    }
}
