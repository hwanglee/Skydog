//
//  SourcePickerListItem.swift
//  Skydog
//
//  Created by Hwang Lee on 3/27/23.
//

import SwiftUI

struct SourcePickerListItem: View {
    @ObservedObject var viewModel: SourceListItemViewModel
    var isSelected: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("**Taper:** \(viewModel.formattedTaper)")
                    .font(.subheadline)
                Text("**Transferrer:** \(viewModel.formattedTransferrer)")
                    .font(.subheadline)
                HStack(spacing: 10) {
                    HStack(spacing: 2) {
                        Text(viewModel.averageRating)
                            .font(.subheadline)
                        Image(systemName: "star.fill").font(.caption)
                    }
                    
                    if viewModel.isSoundboard {
                        SoundboardBadge()
                    }
                    
                    if viewModel.isRemaster {
                        RemasterBadge()
                    }
                }
            }
            
            Spacer(minLength: 10)
            
            if isSelected {
                Image(systemName: "checkmark")
            }
        }
        .contentShape(Rectangle())
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
}

struct SourcePickerListItem_Previews: PreviewProvider {
    static var previews: some View {
        SourceView(viewModel: .init(show: .example))
    }
}
