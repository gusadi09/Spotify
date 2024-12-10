//
//  LibrarySidebarMenuOption.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI

struct MainSidebarMenuOption: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedSection: TabSection
    let section: TabSection
    
    var body: some View {
#if os(iOS)
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
                            Text(Localizable.library)
                        case .search:
                            Text(Localizable.search)
                        case .home:
                            Text(Localizable.home)
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
        .tint(
            selectedSection == section
            ? (colorScheme == .dark ? .white : .black)
            : .gray
        )
#elseif os(macOS)
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
                    .frame(width: 14)
                    
                    Group {
                        switch section {
                        case .library:
                            Text(Localizable.library)
                        case .search:
                            Text(Localizable.search)
                        case .home:
                            Text(Localizable.home)
                        }
                    }
                        .font(
                            selectedSection == section
                            ? .avenirNextDemi(size: 12)
                            :.avenirNextRegular(size: 12)
                        )
                    
                    Spacer()
                }
                .padding(.vertical, 10)
                .contentShape(Rectangle())
            }
        )
        .tint(
            selectedSection == section
            ? (colorScheme == .dark ? .white : .black)
            : .gray
        )
#endif
    }
}

#Preview {
    MainSidebarMenuOption(selectedSection: .constant(.home), section: .home)
}
