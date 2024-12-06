//
//  LibrarySidebarHeadeView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI

struct MainSidebarHeadeView: View {
    let name: String
    let action: () -> Void
    
    init(name: String, action: @escaping () -> Void) {
        self.name = name
        self.action = action
    }
    
    var body: some View {
        #if os(iOS)
        Button(
            action: action,
            label: {
                HStack {
                    Image.Dummy.profile
                        .resizable()
                        .scaledToFit()
                        .frame(height: 55)
                        .clipShape(Circle())
                    
                    Text(name)
                        .font(.avenirNextBold(size: 24))
                        .padding(.horizontal, 4)
                        .foregroundStyle(.foreground)
                }
            }
        )
        #elseif os(macOS)
        Button(
            action: action,
            label: {
                HStack {
                    Image.Dummy.profile
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .clipShape(Circle())
                    
                    Text(name)
                        .font(.avenirNextBold(size: 12))
                        .padding(.horizontal, 4)
                        .foregroundStyle(.foreground)
                }
            }
        )
        #endif
    }
}

#Preview {
    MainSidebarHeadeView(name: "John Doe", action: {})
}
