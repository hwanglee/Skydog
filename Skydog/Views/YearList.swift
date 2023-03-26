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
        List(years, id: \.id) { item in
            NavigationLink {
                YearView(year: item)
            } label: {
                Text(item.year)
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
