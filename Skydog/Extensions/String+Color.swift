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

func textToImage(date: String, venue: String, inImage image: UIImage) -> UIImage {
    let textColor = UIColor.white
    let textFont = UIFont.systemFont(ofSize: 70, weight: .bold)
    
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
    
    let textFontAttributes = [
        NSAttributedString.Key.font: textFont,
        NSAttributedString.Key.foregroundColor: textColor,
    ] as [NSAttributedString.Key : Any]
    image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
    
    let rect = CGRect(origin: .init(x: 20, y: 80),
                      size: .init(width: image.size.width * 0.9, height: image.size.height))
    venue.draw(in: rect, withAttributes: textFontAttributes)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}
