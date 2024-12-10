//
//  SongSearchBarView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 11/12/24.
//

import SwiftUI

struct SongSearchBarView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var search: String
    let cancelAction: () -> Void
    
    var body: some View {
        HStack {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12)
                    .foregroundStyle(.foreground)
                
                TextField(Localizable.search, text: $search)
                    .font(.avenirNextRegular(size: 15))
                    .foregroundStyle(.foreground)
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled(true)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(colorScheme == .dark ? Color.lightGray : .gray.opacity(0.5))
            )
            
            Button(
                action: {
                    cancelAction()
                }, label: {
                    Text(Localizable.cancel)
                        .font(.avenirNextRegular(size: 15))
                }
            )
            .buttonStyle(.plain)
            
            Spacer()
        }
    }
}

#Preview {
    SongSearchBarView(search: .constant(""), cancelAction: {})
}
