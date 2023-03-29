//
//  AsyncContentView.swift
//  Skydog
//
//  Created by Hwang Lee on 3/26/23.
//

import Foundation
import SwiftUI

enum LoadingState<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}

protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load() async
}

struct AsyncContentView<Source: LoadableObject, Content: View>: View {
    @ObservedObject var source: Source
    var content: (Source.Output) -> Content
    
    var body: some View {
        switch source.state {
        case .idle:
            Color.clear
                .onAppear {
                    Task {
                        await source.load()
                    }
                }
        case .loading:
            ProgressView()
        case .failed(let error):
            //            ErrorView(error: error, retryHandler: source.load)
            Text(error.localizedDescription)
        case .loaded(let output):
            content(output)
        }
    }
}
