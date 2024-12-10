//
//  FindSongSheetView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 11/12/24.
//

import SwiftUI

struct FindSongSheetView: View {
    
    @Binding var search: String
    @Binding var songs: [SongData]
    @Binding var recentSearchs: [RecentSearchSong]
    let addSongAction: (SongData) -> Void
    let cancelAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            SongSearchBarView(search: $search) {
                cancelAction()
            }
            
            if search.isEmpty {
                Text(Localizable.recentSearches)
                    .font(.avenirNextDemi(size: 17))
                    .padding(.top)
                
                List {
                    ForEach(recentSearchs, id: \.id) { song in
                        HStack(alignment: .center, spacing: 15) {
                            ImageLoader(url: song.artworkUrl100, height: 65, width: 65)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text(song.trackName)
                                    .font(.avenirNextDemi(size: 15))
                                
                                Text(Localizable.songArtist(song.artistName))
                                    .font(.avenirNextRegular(size: 13))
                                    .foregroundStyle(.gray)
                            }
                            
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
#if os(macOS)
                .frame(width: 300, height: 500)
#endif
            } else {
                List {
                    ForEach(songs, id: \.trackId) { song in
                        HStack(alignment: .center, spacing: 15) {
                            ImageLoader(url: song.artworkUrl100, height: 65, width: 65)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text(song.trackName ?? "-")
                                    .font(.avenirNextDemi(size: 15))
                                
                                Text(Localizable.songArtist(song.artistName ?? "-"))
                                    .font(.avenirNextRegular(size: 13))
                                    .foregroundStyle(.gray)
                            }
                            
                        }
                        .contentShape(Rectangle())
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            addSongAction(song)
                        }
                    }
                }
                .listStyle(.plain)
#if os(macOS)
                .frame(width: 300, height: 500)
#endif
            }
        }
    }
}

#Preview {
    FindSongSheetView(search: .constant(""), songs: .constant([]), recentSearchs: .constant([]), addSongAction: {_ in}, cancelAction: {})
}
