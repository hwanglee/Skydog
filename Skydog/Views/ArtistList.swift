//
//  ArtistList.swift
//  Skydog
//
//  Created by Hwang Lee on 7/11/22.
//

import SwiftUI

struct ArtistList: View {
    @StateObject var viewModel: ArtistListViewModel
    @EnvironmentObject var player: AudioPlayer
    
    var body: some View {
        NavigationView {
            AsyncContentView(source: viewModel) { _ in
                List(viewModel.filteredArtists, id: \.slug) { artist in
                    NavigationLink {
                        ArtistView(viewModel: .init(artist: artist))
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(artist.name)
                            Text("\(artist.showCount) Shows")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding([.top, .bottom], 2)
                    }
                }
                .listStyle(.inset)
                .searchable(text: $viewModel.searchQuery)
            }
            .navigationTitle("Artists")
            .disableAutocorrection(true)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistList(viewModel: .init())
    }
}
