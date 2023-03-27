//
//  SourceView.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct SourceView: View {
    @ObservedObject var viewModel: SourceViewModel
    @State private var showingSheet = false
    @EnvironmentObject var player: AudioPlayer
    
    var body: some View {
        AsyncContentView(source: viewModel) { _ in
            List(viewModel.sets, id: \.uuid) { sourceSet in
                Section {
                    ForEach(sourceSet.tracks, id: \.uuid) { track in
                        Button {
                            player.setTrack(track: track)
                        } label: {
                            HStack(spacing: 20) {
                                Text("\(track.trackPosition)")
                                    .foregroundColor(.secondary)
                                Text(track.title)
                                    .lineLimit(1)
                                Spacer()
                            }
                        }
                    }
                } header: {
                    Text(sourceSet.isEncore ? "Encore" : "Set \(sourceSet.index)")
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Text("Source")
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                SourcePicker(sources: viewModel.sources, selectedSource: $viewModel.selectedSource)
            }
            .listStyle(.inset)
        }
    }
}

struct SourceView_Previews: PreviewProvider {
    static var previews: some View {
        SourceView(viewModel: .init(showUUID: "0"))
    }
}
