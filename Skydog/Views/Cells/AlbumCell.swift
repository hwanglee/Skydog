//
//  AlbumCell.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct AlbumCell: View, Equatable {
    var venue: String
    var date: String
    var image: UIImage
    var rating: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(uiImage: image.preparingThumbnail(of: .init(width: 150, height: 150)) ?? UIImage())
                .resizable()
                .frame(width: 150, height: 150)
                .scaledToFill()
                .clipped()
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(date)
                    .font(.subheadline)
                
                Text(rating)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
        }
        .frame(width: 150)
    }
    
    static func == (lhs: AlbumCell, rhs: AlbumCell) -> Bool {
        return lhs.venue == rhs.venue && lhs.date == rhs.date
    }
}

struct AlbumCell_Previews: PreviewProvider {
    static var previews: some View {
        AlbumCell(venue: "testing a long name to see what happens", date: "test", image: UIImage(named: "\(0)")!, rating: "Rating: 0.0")
    }
}
