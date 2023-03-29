//
//  YearCell.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct YearCell: View, Equatable {
    var year: String
    
    var body: some View {
        Rectangle()
            .fill(Color(uiColor: generateColor(for: year)))
            .overlay(alignment: .center) {
                Text(year)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .cornerRadius(8)
            .frame(width: 150, height: 150)
    }
    
    private func generateColor(for year: String) -> UIColor {
        // Convert the year string to an integer
        guard let yearInt = Int(year) else {
            // Return a default color if the year string is not a valid integer
            return UIColor.gray
        }
        
        // Generate a color based on the year value
        let red = CGFloat((yearInt % 4) * 50) / 255.0
        let green = CGFloat((yearInt % 3) * 60) / 255.0
        let blue = CGFloat((yearInt % 5) * 40) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

struct YearCell_Previews: PreviewProvider {
    static var previews: some View {
        YearCell(year: "2012")
    }
}
