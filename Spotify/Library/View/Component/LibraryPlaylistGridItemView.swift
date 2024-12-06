//
//  LibraryPlaylistGridItemView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI

struct LibraryPlaylistGridItemView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(65), spacing: 0), count: 2), spacing: 0) {
                ForEach(0..<4) {_ in
                    Image.Dummy.profile
                        .resizable()
                        .scaledToFit()
                        .frame(height: 65)
                }
            }
            .scaledToFit()
            .frame(width: 130)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("My First Playlist")
                    .font(.avenirNextDemi(size: 15))
                    .lineLimit(1)
                
                Text("Playlist • 10 songs")
                    .font(.avenirNextRegular(size: 13))
                    .lineLimit(1)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
        }
        .frame(width: 130)
    }
}

#Preview {
    LibraryPlaylistGridItemView()
}
