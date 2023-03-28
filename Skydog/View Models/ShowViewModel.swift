//
//  ShowListItemViewModel.swift
//  Skydog
//
//  Created by Hwang Lee on 3/17/23.
//

import Foundation
import UIKit.UIImage

class ShowViewModel {
    var show: Show
    
    init(show: Show) {
        self.show = show
    }
    
    var albumArt: UIImage {
        let imageIndex = (show.venue?.name.count ?? 0) % 18
        let image = UIImage(named: "\(imageIndex)")
        
        guard let name = show.venue?.name, let image = image else { return UIImage() }
        
        let color = (name + show.displayDate).generateColor().withAlphaComponent(0.1)
        let albumArt = image.tint(tintColor: color).writeText(text: name, textPosition: .left)
        
        return albumArt ?? UIImage()
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: show.displayDate)
        
        guard let date = date else { return show.displayDate }
        
        return date.formatted(date: .numeric, time: .omitted)
    }
    
    var venueName: String { show.venue?.name ?? "" }
}
