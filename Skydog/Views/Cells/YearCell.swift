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
        Image(uiImage: UIImage(named: "\(Int.random(in: 0...17))")!)
            .resizable()
            .frame(width: 150, height: 150)
            .scaledToFill()
            .clipped()
            .cornerRadius(8)
            .frame(width: 150, height: 150)
            .overlay(
                Text(year)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            )
    }
    
    static func == (lhs: YearCell, rhs: YearCell) -> Bool {
        return lhs.year == rhs.year
    }
}

struct YearCell_Previews: PreviewProvider {
    static var previews: some View {
        YearCell(year: "2022")
    }
}
