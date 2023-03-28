//
//  YearCell.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct YearCell: View, Equatable {
    @ObservedObject var viewModel: YearCellViewModel
    
    var body: some View {
        Image(uiImage: viewModel.cellImage)
            .resizable()
            .frame(width: 150, height: 150)
            .scaledToFill()
            .clipped()
            .cornerRadius(8)
            .frame(width: 150, height: 150)
    }
    
    static func == (lhs: YearCell, rhs: YearCell) -> Bool {
        return lhs.viewModel.year.id == rhs.viewModel.year.id
    }
}

struct YearCell_Previews: PreviewProvider {
    static var previews: some View {
        YearCell(viewModel: .init(year: .example))
    }
}
