//
//  LibraryMacOSView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 07/12/24.
//

import SwiftUI

struct LibraryMacOSView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel: LibraryViewModel
    let geo: GeometryProxy
    
    var body: some View {
        VStack {
            List {
                ContentTypeCollectionView(current: $viewModel.currentContentType, content: viewModel.contentTypes)
                    .listRowSeparator(.hidden)
                
                HStack {
                    Spacer()
                    
                    Button(
                        action: {
                            viewModel.changeListType()
                        }, label: {
                            viewModel.currentListTypeIcon()
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16)
                        }
                    )
                }
                .listRowSeparator(.hidden)
                
                switch viewModel.currentListType {
                case .list:
                    ForEach(viewModel.playlists) {
                        LibraryPlaylistItemView(playlist: $0)
                            .listRowSeparator(.hidden)
                    }
                case .grid:
                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible(), spacing: 10),
                            count: viewModel.calculateColumns(for: geo.size.width/1.8)
                        ),
                        spacing: 10
                    ) {
                        ForEach(viewModel.playlists) {
                            LibraryPlaylistGridItemView(playlist: $0)
                        }
                    }
                    .listRowSeparator(.hidden)
                    .padding()
                }
            }
            .listStyle(.plain)
        }
        .buttonStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(
                    action: {
                        viewModel.onMenuButtonTap()
                    },
                    label: {
                        Image.Icons.plus
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26)
                    }
                )
                .popover(isPresented: $viewModel.isShowingMenu) {
                    Button(
                        action: {
                            viewModel.onCreatePlaylistButtonTap()
                        }, label: {
                            HStack {
                                Image.Icons.playlistSheet
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 43)
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                
                                VStack(alignment: .leading) {
                                    Text(Localizable.playlist)
                                        .font(.avenirNextDemi(size: 14))
                                    
                                    Text(Localizable.playlistSubtitle)
                                        .font(.avenirNextDemi(size: 12))
                                        .foregroundStyle(.gray)
                                }
                            }
                            .padding(.horizontal, 5)
                            .padding(.vertical, 10)
                        }
                    )
                    .background(colorScheme == .dark ? Color.black : Color.white)
                }
            }
        }
        .navigationTitle(Text(Localizable.yourLibrary))
        .sheet(isPresented: $viewModel.isShowingForm) {
            CreatePlaylistFormView(viewModel: viewModel)
        }
    }
}

#Preview {
    GeometryReader { geo in
        LibraryMacOSView(viewModel: LibraryViewModel(), geo: geo)
    }
}