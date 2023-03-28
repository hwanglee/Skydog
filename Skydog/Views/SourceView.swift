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
                Section(sourceSet.isEncore ? "Encore" : "Set \(sourceSet.index)") {
                    ForEach(sourceSet.tracks, id: \.uuid) { track in
                        Button {
                            updatePlayer(track: track)
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
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Source") {
                        showingSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                SourcePicker(
                    viewModel: .init(sources: viewModel.sources),
                    selectedSource: $viewModel.selectedSource
                )
            }
            .listStyle(.inset)
        }
    }
    
    func updatePlayer(track: Track) {
        player.setTrack(track: track)
        player.show = .init(show: viewModel.show)
    }
}

struct SourceView_Previews: PreviewProvider {
    static var previews: some View {
        SourceView(viewModel: .init(show: .example))
    }
}
