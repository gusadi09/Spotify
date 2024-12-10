//
//  LibraryDetailHeaderView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 11/12/24.
//

import SwiftUI

struct LibraryDetailHeaderView: View {
    @Binding var songsCount: Int
    @Binding var playlistName: String
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(playlistName)
                    .font(.avenirNextDemi(size: 19))
                
                Text(Localizable.songsCount(songsCount))
                    .font(.avenirNextDemi(size: 12))
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
        }
    }
}

#Preview {
    LibraryDetailHeaderView(songsCount: .constant(0), playlistName: .constant(""))
}
