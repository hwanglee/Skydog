//
//  RatingLabel.swift
//  Skydog
//
//  Created by Hwang Lee on 5/12/23.
//

import SwiftUI

struct RatingLabel: View {
    var rating: Double
    
    init(_ rating: Double) {
        self.rating = rating
    }
    
    var body: some View {
        HStack(spacing: 2) {
            Text("Rating: \(rating, specifier: "%.1f")")
                .font(.footnote)
            
            Image(systemName: "star")
                .font(.system(size: 10))
                .padding(.bottom, 1)
        }
        .foregroundColor(.secondary)
    }
}

struct RatingLabel_Previews: PreviewProvider {
    static var previews: some View {
        RatingLabel(10)
    }
}
