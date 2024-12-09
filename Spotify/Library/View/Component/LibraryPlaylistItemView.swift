//
//  LibraryPlaylistItemView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI

struct LibraryPlaylistItemView: View {
    let playlist: Playlist
    
    var body: some View {
        HStack(spacing: 15) {
            if playlist.songs.isEmpty {
                Rectangle()
                    .scaledToFit()
                    .frame(height: 60)
                    .overlay(
                        Image(systemName: "record.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 35)
                            .foregroundStyle(.background)
                    )
            } else if playlist.songs.count == 1 {
                ImageLoader(url: playlist.songs.first?.artworkUrl100, height: 60)
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(30), spacing: 0), count: 2), spacing: 0) {
                    ForEach(playlist.songs.prefix(4)) {
                        ImageLoader(url: $0.artworkUrl30, height: 30)
                    }
                    
                    if playlist.songs.count <= 3 {
                        ForEach(0...dummyImgPlaylistCount(), id: \.self) { _ in
                            Rectangle()
                                .scaledToFit()
                                .frame(width: 30)
                                .overlay(
                                    Image(systemName: "record.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 15)
                                        .foregroundStyle(.background)
                                )
                        }
                    }
                }
                .scaledToFit()
                .frame(width: 60)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(playlist.playlistName)
                    .font(.avenirNextDemi(size: 15))
                
                Text(Localizable.playlistCountSubtitle(playlist.songs.count))
                    .font(.avenirNextRegular(size: 13))
                    .foregroundStyle(.gray)
            }
            
            Spacer()
        }
    }
    
    func dummyImgPlaylistCount() -> Int {
        playlist.songs.prefix(4).count%2 == 0 ? 1 : 0
    }
}

#Preview {
    LibraryPlaylistItemView(
        playlist: .init(
            id: UUID(),
            timestamp: Date(),
            playlistName: "Test",
            songs: [
                Song.init(
                    id: 1767778808,
                    artistName: "Culth",
                    artworkUrl30: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/30x30bb.jpg"),
                    artworkUrl60: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/60x60bb.jpg"),
                    artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/100x100bb.jpg"),
                    trackName: "Lama-Lama (Bernadya Cover)"
                )
                ,
                Song.init(
                    id: 1767778809,
                    artistName: "Culth",
                    artworkUrl30: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/30x30bb.jpg"),
                    artworkUrl60: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/60x60bb.jpg"),
                    artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/100x100bb.jpg"),
                    trackName: "Lama-Lama (Bernadya Cover)"
                )
                ,
                Song.init(
                    id: 1767778805,
                    artistName: "Culth",
                    artworkUrl30: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/30x30bb.jpg"),
                    artworkUrl60: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/60x60bb.jpg"),
                    artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/100x100bb.jpg"),
                    trackName: "Lama-Lama (Bernadya Cover)"
                )
            ]
        )
    )
}
