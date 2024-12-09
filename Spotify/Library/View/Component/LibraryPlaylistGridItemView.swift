//
//  LibraryPlaylistGridItemView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI

struct LibraryPlaylistGridItemView: View {
    let playlist: Playlist
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            if playlist.songs.isEmpty {
                Rectangle()
                    .scaledToFit()
                    .overlay(
                        Image(systemName: "record.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 70)
                            .foregroundStyle(.background)
                    )
            } else if playlist.songs.count == 1 {
                ImageLoader(url: playlist.songs.first?.artworkUrl100, height: nil)
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(85), spacing: 0), count: 2), spacing: 0) {
                    ForEach(playlist.songs.prefix(4)) {
                        ImageLoader(url: $0.artworkUrl60, height: nil)
                    }
                    
                    if playlist.songs.count <= 3 {
                        ForEach(0...dummyImgPlaylistCount(), id: \.self) { _ in
                            Rectangle()
                                .scaledToFit()
                                .overlay(
                                    Image(systemName: "record.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 50)
                                        .foregroundStyle(.background)
                                )
                        }
                    }
                }
                .scaledToFit()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(playlist.playlistName)
                    .font(.avenirNextDemi(size: 15))
                    .lineLimit(1)
                
                Text(Localizable.playlistCountSubtitle(playlist.songs.count))
                    .font(.avenirNextRegular(size: 13))
                    .lineLimit(1)
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
    LibraryPlaylistGridItemView(
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
