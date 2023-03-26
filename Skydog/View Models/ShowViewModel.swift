//
//  ShowViewModel.swift
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
        
        return image ?? UIImage()
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: show.displayDate)
        
        guard let date = date else { return show.displayDate }
        
        return date.formatted(date: .long, time: .omitted)
    }
}
