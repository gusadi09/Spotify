//
//  PlaylistSongItemView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 11/12/24.
//

import SwiftUI

struct PlaylistSongItemView: View {
    let song: Song
    
    var body: some View {
        HStack {
            ImageLoader(url: song.artworkUrl100, height: 55, width: 55)
                .clipShape(Rectangle())
            
            VStack(alignment: .leading, spacing: 8) {
                Text(song.trackName)
                    .font(.avenirNextDemi(size: 14))
                    .lineLimit(1)
                
                Text(song.artistName)
                    .font(.avenirNextRegular(size: 11))
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Button(action:{
                
            }, label: {
                Image.Icons.moreOption
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 18)
            })
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    PlaylistSongItemView(song: Song(id: 0, artistName: "", artworkUrl30: nil, artworkUrl60: nil, artworkUrl100: nil, trackName: ""))
}
