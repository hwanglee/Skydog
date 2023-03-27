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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(uiImage: image)
                .resizable()
                .frame(width: 150, height: 150)
                .scaledToFill()
                .clipped()
                .overlay(Color((venue + date).generateColor()).opacity(0.3))
                .overlay(
                    Text(venue)
                        .fontWeight(.bold)
                        .font(.title3)
                        .padding(8)
                        .foregroundColor(.white),
                    alignment: .topLeading
                )
                .cornerRadius(8)
            Text(venue.trimmingCharacters(in: .whitespacesAndNewlines))
                .font(.subheadline)
                .lineLimit(2)
            Text(date)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .multilineTextAlignment(.leading)
        .frame(width: 150)
    }
    
    static func == (lhs: AlbumCell, rhs: AlbumCell) -> Bool {
        return lhs.venue == rhs.venue && lhs.date == rhs.date
    }
}

struct AlbumCell_Previews: PreviewProvider {
    static var previews: some View {
        AlbumCell(venue: "testing a long name to see what happens", date: "test", image: UIImage(named: "\(0)")!)
    }
}
