//
//  YearList.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct YearList: View {
    var years: [Year]
    
    var body: some View {
        List(years, id: \.id) { year in
            NavigationLink {
                YearView(viewModel: .init(year: year))
            } label: {
                VStack(alignment: .leading, spacing: 4) {
                    Text(year.year)
                    Text("\(year.showCount) Shows")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding([.top, .bottom], 2)
            }
        }
        .listStyle(.inset)
        .navigationTitle("Years")
    }
}

struct YearListView_Previews: PreviewProvider {
    static var previews: some View {
        YearList(years: [.example])
    }
}
