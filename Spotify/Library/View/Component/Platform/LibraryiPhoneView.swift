//
//  LibraryiPhoneView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 07/12/24.
//

import SwiftUI

#if os(iOS)
struct LibrayiPhoneView: View {
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
                    ForEach(viewModel.playlists) { item in
                        Button(action: {
                            viewModel.selectedPlaylist = item
                        }, label:{
                            LibraryPlaylistItemView(playlist: item)
                                .contentShape(Rectangle())
                        })
                        .listRowSeparator(.hidden)
                    }
                case .grid:
                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible(), spacing: 10),
                            count: viewModel.calculateColumns(for: geo.size.width/1.4)
                        ),
                        spacing: 10
                    ) {
                        ForEach(viewModel.playlists) { item in
                            Button(action: {
                                viewModel.selectedPlaylist = item
                            }, label:{
                                LibraryPlaylistGridItemView(playlist: item)
                                    .contentShape(Rectangle())
                            })
                        }
                    }
                    .listRowSeparator(.hidden)
                    .padding(.horizontal)
                }
            }
            .listStyle(.plain)
        }
        .buttonStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(
                    action: {
                        
                    },
                    label: {
                        HStack {
                            Image.Dummy.profile
                                .resizable()
                                .scaledToFit()
                                .frame(height: 35)
                                .clipShape(Circle())
                            
                            Text(Localizable.yourLibrary)
                                .font(.avenirNextDemi(size: 24))
                                .padding(.horizontal, 4)
                        }
                    }
                )
            }
            
            ToolbarItem(placement: .topBarTrailing) {
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
            }
        }
        .sheet(isPresented: $viewModel.isShowingMenu) {
            VStack {
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
                            
                            Spacer()
                        }
                        .padding()
                    }
                )
            }
            .presentationDetents([.height(100)])
        }
        .sheet(isPresented: $viewModel.isShowingForm) {
            CreatePlaylistFormView(viewModel: viewModel)
        }
        .navigationDestination(item: $viewModel.selectedPlaylist) {
            LibraryDetailView(viewModel: LibraryDetailViewModel(playlist: $0))
        }
    }
}

#Preview {
    @Previewable @Environment(\.colorScheme) var colorScheme
    
    GeometryReader { geo in
        NavigationStack {
            LibrayiPhoneView(viewModel: LibraryViewModel(), geo: geo)
        }
        .tint(colorScheme == .dark ? .white : .black)
    }
}

#endif

