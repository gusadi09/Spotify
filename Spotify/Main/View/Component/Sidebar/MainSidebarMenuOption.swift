//
//  LibrarySidebarMenuOption.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI

struct MainSidebarMenuOption: View {
    @Binding var selectedSection: TabSection
    let section: TabSection
    
    var body: some View {
        Button(
            action: {
                selectedSection = section
            }, label: {
                HStack(alignment: .center) {
                    Group {
                        switch section {
                        case .library:
                            Image.Icons.library
                                .renderingMode(.template)
                                .resizable()
                        case .search:
                            Image.Icons.search
                                .renderingMode(.template)
                                .resizable()
                        case .home:
                            (
                                selectedSection == section
                                ? Image.Icons.homeFill
                                : Image.Icons.home
                            )
                            .renderingMode(.template)
                            .resizable()
                        }
                    }
                    .scaledToFit()
                    .frame(width: 20)
                    
                    Group {
                        switch section {
                        case .library:
                            Text("Library")
                        case .search:
                            Text("Search")
                        case .home:
                            Text("Home")
                        }
                    }
                        .font(
                            selectedSection == section
                            ? .avenirNextDemi(size: 18)
                            :.avenirNextRegular(size: 18)
                        )
                    
                    Spacer()
                }
                .padding(.vertical, 10)
                .contentShape(Rectangle())
            }
        )
        .tint(selectedSection == section ? .white : .gray)
    }
}

#Preview {
    MainSidebarMenuOption(selectedSection: .constant(.home), section: .home)
}
