//
//  String+Color.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import UIKit

extension String {
    func generateColor() -> UIColor {
        let hash = abs(self.hashValue)
        let colorNum = hash % (50 * 50 * 50)
        let red = colorNum >> 16
        let green = (colorNum & 0x00FF00) >> 8
        let blue = (colorNum & 0x0000FF)
        let color = UIColor(red: CGFloat(red) / 255.0,
                            green: CGFloat(green) / 255.0,
                            blue: CGFloat(blue) / 255.0,
                            alpha: 1.0)
        
        return color
    }
}
