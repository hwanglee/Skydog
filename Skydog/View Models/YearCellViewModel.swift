//
//  YearCellViewModel.swift
//  Skydog
//
//  Created by Hwang Lee on 3/28/23.
//

import Foundation
import UIKit.UIImage

class YearCellViewModel: ObservableObject {
    private(set) var year: Year
    
    var cellImage: UIImage {
        let imageIndex = (Int(year.year) ?? 0) % 18
        let image = UIImage(named: "\(imageIndex)")
        
        guard let image = image else { return UIImage() }
        
        let color = (year.year + year.artistUuid).generateColor().withAlphaComponent(0.1)
        let albumArt = image.tint(tintColor: color).writeText(text: year.year, textPosition: .center)
        
        return albumArt ?? UIImage()
    }
    
    init(year: Year) {
        self.year = year
    }
}
