//
//  Capsule.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI

struct CapsuleView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var current: ContentType
    let value: ContentType
    
    init(current: Binding<ContentType>, _ value: ContentType) {
        self._current = current
        self.value = value
    }
    
    var body: some View {
        if current == value {
            Text(value.rawValue.capitalized)
                .font(.avenirNextRegular(size: 12))
                .foregroundStyle(.background)
                .padding(.vertical, 12)
                .padding(.horizontal, 25)
                .background(Capsule())
        } else {
            Text(value.rawValue.capitalized)
                .font(.avenirNextRegular(size: 12))
                .foregroundStyle(.foreground)
                .padding(.vertical, 12)
                .padding(.horizontal, 25)
                .background(Capsule().stroke(lineWidth: 1))
        }
    }
}

#Preview {
    CapsuleView(current: .constant(.noOption), .playlists)
}
