//
//  SourceViewModel.swift
//  Skydog
//
//  Created by Hwang Lee on 3/27/23.
//

import Foundation

class SourceViewModel: LoadableObject {
    typealias Output = [Source]
    
    @Published var state: LoadingState<[Source]> = .idle
    @Published var sources: [Source] = []
    @Published var selectedSource: Source?
    
    var sets: [SourceSet] { selectedSource?.sets ?? [] }
    var infoLabel: String? {
        let numberOfTracks = selectedSource?.sets.reduce(0) { $0 + $1.tracks.count }
        let totalTime = selectedSource?.sets.reduce(0) { $0 + $1.tracks.reduce(0) { $0 + ($1.duration ?? 0) } }
        
        guard let numberOfTracks = numberOfTracks, let totalTime = totalTime else { return nil }
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .full
//        formatter.zeroFormattingBehavior = .pad

        guard var formattedDuration = formatter.string(from: TimeInterval(totalTime)) else { return nil }
        formattedDuration.replace(",", with: "")
        
        return "\(numberOfTracks) Tracks, \(formattedDuration)"
    }
    
    private(set) var show: Show
    
    init(show: Show) {
        self.show = show
    }
    
    @MainActor
    func load() async {
        state = .loading
        
        do {
            sources = try await DataLoader.shared.fetchSources(showUUID: show.uuid)
            sources.sort { $0.avgRating > $1.avgRating }
            
            selectedSource = sources.first
            
            state = .loaded(sources)
        } catch {
            state = .failed(error)
            
            switch error {
            case DecodingError.dataCorrupted(let context):
                print(context)
            case DecodingError.keyNotFound(let key, let context):
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case DecodingError.valueNotFound(let value, let context):
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case DecodingError.typeMismatch(let type, let context):
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            default:
                print("error: ", error)
            }
        }
    }
}
