//
//  YearView.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct YearView: View {
    @ObservedObject var viewModel: YearViewModel
    
    var body: some View {
        AsyncContentView(source: viewModel) { _ in
            ShowsList(shows: viewModel.shows.map { .init(show: $0) })
                .navigationTitle(viewModel.year.year)
        }
    }
}

struct YearView_Previews: PreviewProvider {
    static var previews: some View {
        YearView(viewModel: .init(year: .example))
    }
}
