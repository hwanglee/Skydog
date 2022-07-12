//
//  SourcePickerView.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct SourcePickerView: View {
    @State private var selectedSort: Int = 0
    @State var sources: [Source]
    @Binding var selectedSource: Source?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List(sources, id: \.uuid) { source in
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("**Taper:** \(source.formattedTaper)")
                            .font(.subheadline)
                        Text("**Transferrer:** \(source.formattedTransferrer)")
                            .font(.subheadline)
                        HStack {
                            Text(String(format: "%.1f", source.avgRating))
                                .font(.subheadline)
                            Image(systemName: "star.fill").font(.caption)
                            
                            if source.isSoundboard {
                                SoundboardBadge()
                            }
                            
                            if source.isRemaster {
                                RemasterBadge()
                            }
                        }
                    }
                    
                    Spacer(minLength: 10)
                    
                    if selectedSource?.uuid == source.uuid {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
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
                    Menu {
                        Picker("Sort", selection: $selectedSort) {
                            Label("Rating (Highest)", systemImage: "arrow.up").tag(0)
                            Label("Rating (Lowest)", systemImage: "arrow.down").tag(1)
                        }
                    } label: {
                        Text("Sort")
                    }
                }
            }
        }
        .onChange(of: selectedSort) { tag in
            switch tag {
            case 0: sources.sort { $0.avgRating > $1.avgRating }
            case 1: sources.sort { $0.avgRating < $1.avgRating }
            default: print("fail")
            }
        }
    }
}

//struct SourceListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SourceListView()
//    }
//}
