//
//  UIImage+Text.swift
//  Skydog
//
//  Created by Hwang Lee on 3/28/23.
//

import UIKit.UIImage

extension UIImage {
    func writeText(text: String, textPosition: NSTextAlignment) -> UIImage? {
        let textColor = UIColor.white
        let textFont = UIFont.preferredFont(forTextStyle: .headline).withSize(22)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textPosition
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        
        // Create a copy of the image to write text onto
        UIGraphicsBeginImageContextWithOptions(size, false, 2.5)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        // Determine the size of the text and its position on the image
        let textPadding: CGFloat = 10
        let textSize = text.size(withAttributes: textFontAttributes)
        var textRect: CGRect = .zero
        
        if textPosition == .center {
            textRect = CGRect(
                x: (size.width - textSize.width) / 2,
                y: (size.height - textSize.height) / 2,
                width: textSize.width,
                height: textSize.height
            )
        } else {
            textRect = CGRect(
                x: textPadding,
                y: textPadding,
                width: size.width - (textPadding * 2),
                height: size.height - (textPadding * 2)
            )
        }
        
        // Draw the text onto the image with word wrapping
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
        // Retrieve the image with the text written onto it
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

