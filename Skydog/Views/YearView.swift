//
//  YearView.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct YearView: View {
    var year: Year
    @State private var shows = [Show]()
    
    var body: some View {
        ShowsList(shows: shows.map { .init(show: $0) })
            .navigationTitle(year.year)
            .task {
                try? await loadData()
            }
    }
    
    private func loadData() async throws {
        async let shows = DataLoader.shared.fetchShows(artistSlug: year.artistUuid, year: year.year)
        self.shows = try await shows
        print(self.shows)
    }
}

struct YearView_Previews: PreviewProvider {
    static var previews: some View {
        YearView(year: .example)
    }
}
