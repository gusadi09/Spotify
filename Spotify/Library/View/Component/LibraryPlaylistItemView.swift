//
//  LibraryPlaylistItemView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI

struct LibraryPlaylistItemView: View {
    var body: some View {
        HStack(spacing: 15) {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(30), spacing: 0), count: 2), spacing: 0) {
                ForEach(0..<4) {_ in
                    Image.Dummy.profile
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                }
            }
            .scaledToFit()
            .frame(width: 60)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("My First Playlist")
                    .font(.avenirNextDemi(size: 15))
                
                Text("Playlist • 10 songs")
                    .font(.avenirNextRegular(size: 13))
                    .foregroundStyle(.gray)
            }
            
            Spacer()
        }
    }
}

#Preview {
    LibraryPlaylistItemView()
}
