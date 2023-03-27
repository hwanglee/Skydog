//
//  SourcePicker.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct SourcePicker: View {
    @ObservedObject var viewModel: SourcePickerViewModel
    @Binding var selectedSource: Source?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List(viewModel.sources, id: \.uuid) { source in
                SourcePickerListItem(
                    viewModel: .init(source: source),
                    isSelected: source.uuid == selectedSource?.uuid
                )
                .onTapGesture {
                    selectedSource = source
                    dismiss()
                }
            }
            .listStyle(.plain)
            .navigationBarTitle("Sources", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu("Sort") {
                        Section("Sort By") {
                            Picker("Sort", selection: $viewModel.sortOption) {
                                ForEach(SourcePickerViewModel.SortOption.allCases, id: \.self) { option in
                                    Label(option.title, systemImage: option.imageName).tag(option)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct SourceListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SourceListView()
//    }
//}
