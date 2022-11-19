//
//  SourceView.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct SourceView: View {
    var show: Show
    @State private var sources = [Source]()
    @State private var showingSheet = false
    @State private var selectedSource: Source?
    
    var body: some View {
        List(selectedSource?.sets ?? [], id: \.uuid) { sourceSet in
            Section {
                ForEach(sourceSet.tracks, id: \.uuid) { track in
                    Button {
                        AudioPlayer.instance.setTrack(track: track)
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
            SourcePickerView(sources: sources, selectedSource: $selectedSource)
        }
        .navigationTitle(show.displayDate)
        .listStyle(.inset)
        .onAppear(perform: loadData)
    }
    
    private func loadData() {
        Task.init {
            do {
                async let sources = DataLoader.shared.fetchSources(showUUID: show.uuid)
                
                self.sources = try await sources
                self.sources.sort { $0.avgRating > $1.avgRating }
                
                selectedSource = self.sources.first
            } catch DecodingError.dataCorrupted(let context) {
                print(context)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
    }
}

//struct SourceView_Previews: PreviewProvider {
//    static var previews: some View {
//        SourceView()
//    }
//}
