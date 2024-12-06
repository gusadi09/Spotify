//
//  ContentTypeCollectionView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 07/12/24.
//

import SwiftUI

struct ContentTypeCollectionView: View {
    @Binding var current: ContentType
    let content: [ContentType]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ForEach(content, id: \.rawValue) { type in
                CapsuleView(current: $current, type)
                    .contentShape(Capsule())
                    .onTapGesture {
                        current = current == type ? .noOption : type
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 5)
            }
        }
    }
}

#Preview {
    ContentTypeCollectionView(current: .constant(.playlists), content: [.playlists])
}
