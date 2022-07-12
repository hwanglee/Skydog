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
        ShowsListView(shows: shows)
            .navigationTitle(year.year)
            .onAppear(perform: loadData)
    }
    
    private func loadData() {
        Task.init {
            async let years = DataLoader.shared.fetchShows(artistSlug: year.artistUuid, year: year.year)
            self.shows = try await years
            print(self.shows)
        }
    }
}

//struct YearView_Previews: PreviewProvider {
//    static var previews: some View {
//        YearView()
//    }
//}
