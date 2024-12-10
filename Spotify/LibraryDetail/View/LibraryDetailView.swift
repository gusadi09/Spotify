//
//  LibraryDetailView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 09/12/24.
//

import SwiftUI

struct LibraryDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel: LibraryDetailViewModel
    
    var body: some View {
        List {
            LibraryDetailHeaderView(songsCount: $viewModel.countedSongs, playlistName: $viewModel.playlist.playlistName)
                .padding(.vertical)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            
            ForEach(viewModel.playlist.songs, id: \.id) { song in
                PlaylistSongItemView(song: song)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .background(
            LinearGradient(
                colors: [
                    .deepPurple,
                    colorScheme == .dark ? .black : .white,
                    colorScheme == .dark ? .black : .white
                ],
                startPoint: .top,
                endPoint: .center
            )
        )
        .navigationBarBackButtonHidden(true)
        .toolbar {
            #if os(iOS)
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image.Icons.back
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .foregroundStyle(.foreground)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(
                    action: {
                        viewModel.toggleSearchSheet()
                    },
                    label: {
                        Image.Icons.plus
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundStyle(.foreground)
                    }
                )
            }
#elseif os(macOS)
            ToolbarItem(placement: .navigation) {
                Button {
                    dismiss()
                } label: {
                    Image.Icons.back
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .foregroundStyle(.foreground)
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button(
                    action: {
                        viewModel.toggleSearchSheet()
                    },
                    label: {
                        Image.Icons.plus
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundStyle(.foreground)
                    }
                )
            }
#endif
        }
#if os(iOS)
        .toolbarBackground(.deepPurple, for: .navigationBar)
#endif
        .sheet(
            isPresented: $viewModel.showSearch,
            onDismiss: {viewModel.resetSearch()},
            content: {
                FindSongSheetView(
                    search: $viewModel.searchSong,
                    songs: $viewModel.songs,
                    recentSearchs: $viewModel.recentSearchs,
                    addSongAction: { song in
                        Task {
                            await viewModel.addToPlaylist(song)
                            await viewModel.saveRecentSearch(song)
                            
                            viewModel.showSearch = false
                        }
                    },
                    cancelAction: {
                        viewModel.toggleSearchSheet()
                    }
                )
                .padding()
            }
        )
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
#if os(iOS)
    if UIDevice.current.userInterfaceIdiom == .pad {
        NavigationSplitView {
            
        } detail: {
            LibraryDetailView(
                viewModel: LibraryDetailViewModel(
                    playlist: .init(
                        id: UUID(),
                        timestamp: Date(),
                        playlistName: "Test",
                        songs: [
                            Song.init(
                                id: 1767778808,
                                artistName: "Culth",
                                artworkUrl30: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/30x30bb.jpg"),
                                artworkUrl60: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/60x60bb.jpg"),
                                artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/100x100bb.jpg"),
                                trackName: "Lama-Lama (Bernadya Cover)"
                            )
                            ,
                            Song.init(
                                id: 1767778809,
                                artistName: "Culth",
                                artworkUrl30: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/30x30bb.jpg"),
                                artworkUrl60: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/60x60bb.jpg"),
                                artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/100x100bb.jpg"),
                                trackName: "Lama-Lama (Bernadya Cover)"
                            )
                            ,
                            Song.init(
                                id: 1767778805,
                                artistName: "Culth",
                                artworkUrl30: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/30x30bb.jpg"),
                                artworkUrl60: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/60x60bb.jpg"),
                                artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/100x100bb.jpg"),
                                trackName: "Lama-Lama (Bernadya Cover)"
                            )
                        ]
                    )
                )
            )
        }
    } else {
        NavigationStack {
            LibraryDetailView(
                viewModel: LibraryDetailViewModel(
                    playlist: .init(
                        id: UUID(),
                        timestamp: Date(),
                        playlistName: "Test",
                        songs: [
                            Song.init(
                                id: 1767778808,
                                artistName: "Culth",
                                artworkUrl30: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/30x30bb.jpg"),
                                artworkUrl60: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/60x60bb.jpg"),
                                artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/100x100bb.jpg"),
                                trackName: "Lama-Lama (Bernadya Cover)"
                            )
                            ,
                            Song.init(
                                id: 1767778809,
                                artistName: "Culth",
                                artworkUrl30: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/30x30bb.jpg"),
                                artworkUrl60: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/60x60bb.jpg"),
                                artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/100x100bb.jpg"),
                                trackName: "Lama-Lama (Bernadya Cover)"
                            )
                            ,
                            Song.init(
                                id: 1767778805,
                                artistName: "Culth",
                                artworkUrl30: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/30x30bb.jpg"),
                                artworkUrl60: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/60x60bb.jpg"),
                                artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/100x100bb.jpg"),
                                trackName: "Lama-Lama (Bernadya Cover)"
                            )
                        ]
                    )
                )
            )
        }
    }
#elseif os(macOS)
    NavigationSplitView {
        
    } detail: {
        LibraryDetailView(
            viewModel: LibraryDetailViewModel(
                playlist: .init(
                    id: UUID(),
                    timestamp: Date(),
                    playlistName: "Test",
                    songs: [
                        Song.init(
                            id: 1767778808,
                            artistName: "Culth",
                            artworkUrl30: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/30x30bb.jpg"),
                            artworkUrl60: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/60x60bb.jpg"),
                            artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/100x100bb.jpg"),
                            trackName: "Lama-Lama (Bernadya Cover)"
                        )
                        ,
                        Song.init(
                            id: 1767778809,
                            artistName: "Culth",
                            artworkUrl30: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/30x30bb.jpg"),
                            artworkUrl60: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/60x60bb.jpg"),
                            artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/100x100bb.jpg"),
                            trackName: "Lama-Lama (Bernadya Cover)"
                        )
                        ,
                        Song.init(
                            id: 1767778805,
                            artistName: "Culth",
                            artworkUrl30: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/30x30bb.jpg"),
                            artworkUrl60: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/60x60bb.jpg"),
                            artworkUrl100: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/4f/52/fa/4f52fa5b-0e3b-a140-2e41-78252b17754d/5063585747253_cover.jpg/100x100bb.jpg"),
                            trackName: "Lama-Lama (Bernadya Cover)"
                        )
                    ]
                )
            )
        )
    }
#endif
}
