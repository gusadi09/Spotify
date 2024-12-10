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
        Group {
#if os(iOS)
            if UIDevice.current.userInterfaceIdiom == .pad {
                List {
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(viewModel.playlist.playlistName)
                                .font(.avenirNextDemi(size: 19))
                            
                            Text(Localizable.songsCount(viewModel.playlist.songs.count))
                                .font(.avenirNextDemi(size: 12))
                                .foregroundStyle(.gray)
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.vertical)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    
                    ForEach(viewModel.playlist.songs, id: \.id) { song in
                        HStack {
                            ImageLoader(url: song.artworkUrl100, height: 55, width: 55)
                                .clipShape(Rectangle())
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(song.trackName)
                                    .font(.avenirNextDemi(size: 14))
                                    .lineLimit(1)
                                
                                Text(song.artistName)
                                    .font(.avenirNextRegular(size: 11))
                                    .foregroundStyle(.gray)
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                            
                            Button(action:{
                                
                            }, label: {
                                Image.Icons.moreOption
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 18)
                            })
                            .buttonStyle(.plain)
                        }
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
                                viewModel.showSearch = true
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
                }
                .toolbarBackground(.deepPurple, for: .navigationBar)
                .sheet(
                    isPresented: $viewModel.showSearch,
                    onDismiss: {viewModel.searchSong = ""},
                    content: {
                        VStack(alignment: .leading) {
                            HStack {
                                HStack(alignment: .center, spacing: 10) {
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 12)
                                        .foregroundStyle(.foreground)
                                    
                                    TextField(Localizable.search, text: $viewModel.searchSong)
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
                                        viewModel.showSearch = false
                                    }, label: {
                                        Text(Localizable.cancel)
                                            .font(.avenirNextRegular(size: 15))
                                    }
                                )
                                .buttonStyle(.plain)
                                
                                Spacer()
                            }
                            
                            if viewModel.searchSong.isEmpty {
                                Text("Recent searches")
                                    .font(.avenirNextDemi(size: 17))
                                    .padding(.top)
                                
                                List {
                                    ForEach(viewModel.recentSearchs, id: \.id) { song in
                                        HStack(alignment: .center, spacing: 15) {
                                            ImageLoader(url: song.artworkUrl100, height: 65, width: 65)
                                                .clipShape(Circle())
                                            
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text(song.trackName)
                                                    .font(.avenirNextDemi(size: 15))
                                                
                                                Text("Song • \(song.artistName)")
                                                    .font(.avenirNextRegular(size: 13))
                                                    .foregroundStyle(.gray)
                                            }
                                            
                                        }
                                        .listRowSeparator(.hidden)
                                    }
                                }
                                .listStyle(.plain)
                            } else {
                                List {
                                    ForEach(viewModel.songs, id: \.trackId) { song in
                                        HStack(alignment: .center, spacing: 15) {
                                            ImageLoader(url: song.artworkUrl100, height: 65, width: 65)
                                                .clipShape(Circle())
                                            
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text(song.trackName ?? "-")
                                                    .font(.avenirNextDemi(size: 15))
                                                
                                                Text("Song • \(song.artistName ?? "-")")
                                                    .font(.avenirNextRegular(size: 13))
                                                    .foregroundStyle(.gray)
                                            }
                                            
                                        }
                                        .contentShape(Rectangle())
                                        .listRowSeparator(.hidden)
                                        .onTapGesture {
                                            Task {
                                                await viewModel.addToPlaylist(song)
                                                await viewModel.saveRecentSearch(song)
                                                
                                                viewModel.showSearch = false
                                            }
                                        }
                                    }
                                }
                                .listStyle(.plain)
                            }
                        }
                        .padding()
                    }
                )
            } else {
                List {
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(viewModel.playlist.playlistName)
                                .font(.avenirNextDemi(size: 19))
                            
                            Text(Localizable.songsCount(viewModel.playlist.songs.count))
                                .font(.avenirNextDemi(size: 12))
                                .foregroundStyle(.gray)
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.vertical)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    
                    ForEach(viewModel.playlist.songs, id: \.id) { song in
                        HStack {
                            ImageLoader(url: song.artworkUrl100, height: 55, width: 55)
                                .clipShape(Rectangle())
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(song.trackName)
                                    .font(.avenirNextDemi(size: 14))
                                    .lineLimit(1)
                                
                                Text(song.artistName)
                                    .font(.avenirNextRegular(size: 11))
                                    .foregroundStyle(.gray)
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                            
                            Button(action:{
                                
                            }, label: {
                                Image.Icons.moreOption
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 18)
                            })
                            .buttonStyle(.plain)
                        }
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
                                viewModel.showSearch = true
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
                }
                .toolbarBackground(.deepPurple, for: .navigationBar)
                .sheet(
                    isPresented: $viewModel.showSearch,
                    onDismiss: {viewModel.searchSong = ""},
                    content: {
                        VStack(alignment: .leading) {
                            HStack {
                                HStack(alignment: .center, spacing: 10) {
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 12)
                                        .foregroundStyle(.foreground)
                                    
                                    TextField(Localizable.search, text: $viewModel.searchSong)
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
                                        viewModel.showSearch = false
                                    }, label: {
                                        Text(Localizable.cancel)
                                            .font(.avenirNextRegular(size: 15))
                                    }
                                )
                                .buttonStyle(.plain)
                                
                                Spacer()
                            }
                            
                            if viewModel.searchSong.isEmpty {
                                Text("Recent searches")
                                    .font(.avenirNextDemi(size: 17))
                                    .padding(.top)
                                
                                List {
                                    ForEach(viewModel.recentSearchs, id: \.id) { song in
                                        HStack(alignment: .center, spacing: 15) {
                                            ImageLoader(url: song.artworkUrl100, height: 65, width: 65)
                                                .clipShape(Circle())
                                            
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text(song.trackName)
                                                    .font(.avenirNextDemi(size: 15))
                                                
                                                Text("Song • \(song.artistName)")
                                                    .font(.avenirNextRegular(size: 13))
                                                    .foregroundStyle(.gray)
                                            }
                                            
                                        }
                                        .listRowSeparator(.hidden)
                                    }
                                }
                                .listStyle(.plain)
                            } else {
                                List {
                                    ForEach(viewModel.songs, id: \.trackId) { song in
                                        HStack(alignment: .center, spacing: 15) {
                                            ImageLoader(url: song.artworkUrl100, height: 65, width: 65)
                                                .clipShape(Circle())
                                            
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text(song.trackName ?? "-")
                                                    .font(.avenirNextDemi(size: 15))
                                                
                                                Text("Song • \(song.artistName ?? "-")")
                                                    .font(.avenirNextRegular(size: 13))
                                                    .foregroundStyle(.gray)
                                            }
                                            
                                        }
                                        .contentShape(Rectangle())
                                        .listRowSeparator(.hidden)
                                        .onTapGesture {
                                            Task {
                                                await viewModel.addToPlaylist(song)
                                                await viewModel.saveRecentSearch(song)
                                                
                                                viewModel.showSearch = false
                                            }
                                        }
                                    }
                                }
                                .listStyle(.plain)
                            }
                        }
                        .padding()
                    }
                )
            }
#elseif os(macOS)
            List {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(viewModel.playlist.playlistName)
                            .font(.avenirNextDemi(size: 19))
                        
                        Text(Localizable.songsCount(viewModel.playlist.songs.count))
                            .font(.avenirNextDemi(size: 12))
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                }
                .padding(.vertical)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
                ForEach(viewModel.playlist.songs, id: \.id) { song in
                    HStack {
                        ImageLoader(url: song.artworkUrl100, height: 55, width: 55)
                            .clipShape(Rectangle())
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(song.trackName)
                                .font(.avenirNextDemi(size: 14))
                                .lineLimit(1)
                            
                            Text(song.artistName)
                                .font(.avenirNextRegular(size: 11))
                                .foregroundStyle(.gray)
                                .lineLimit(1)
                        }
                        
                        Spacer()
                        
                        Button(action:{
                            
                        }, label: {
                            Image.Icons.moreOption
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 18)
                        })
                        .buttonStyle(.plain)
                    }
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
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(
                        action: {
                            viewModel.showSearch = true
                        },
                        label: {
                            Image.Icons.plus
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26)
                                .foregroundStyle(.foreground)
                        }
                    )
                }
            }
            .sheet(
                isPresented: $viewModel.showSearch,
                onDismiss: {viewModel.searchSong = ""},
                content: {
                    VStack(alignment: .leading) {
                        HStack {
                            HStack(alignment: .center, spacing: 10) {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12)
                                    .foregroundStyle(.foreground)
                                
                                TextField(Localizable.search, text: $viewModel.searchSong)
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
                                    viewModel.showSearch = false
                                }, label: {
                                    Text(Localizable.cancel)
                                        .font(.avenirNextRegular(size: 15))
                                }
                            )
                            .buttonStyle(.plain)
                            
                            Spacer()
                        }
                        
                        if viewModel.searchSong.isEmpty {
                            Text("Recent searches")
                                .font(.avenirNextDemi(size: 17))
                                .padding(.top)
                            
                            List {
                                ForEach(viewModel.recentSearchs, id: \.id) { song in
                                    HStack(alignment: .center, spacing: 15) {
                                        ImageLoader(url: song.artworkUrl100, height: 65, width: 65)
                                            .clipShape(Circle())
                                        
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text(song.trackName)
                                                .font(.avenirNextDemi(size: 15))
                                            
                                            Text("Song • \(song.artistName)")
                                                .font(.avenirNextRegular(size: 13))
                                                .foregroundStyle(.gray)
                                        }
                                        
                                    }
                                    .listRowSeparator(.hidden)
                                }
                            }
                            .frame(minWidth: 300, minHeight: 500)
                        } else {
                            List {
                                ForEach(viewModel.songs, id: \.trackId) { song in
                                    HStack(alignment: .center, spacing: 15) {
                                        ImageLoader(url: song.artworkUrl100, height: 65, width: 65)
                                            .clipShape(Circle())
                                        
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text(song.trackName ?? "-")
                                                .font(.avenirNextDemi(size: 15))
                                            
                                            Text("Song • \(song.artistName ?? "-")")
                                                .font(.avenirNextRegular(size: 13))
                                                .foregroundStyle(.gray)
                                        }
                                        
                                    }
                                    .contentShape(Rectangle())
                                    .listRowSeparator(.hidden)
                                    .onTapGesture {
                                        Task {
                                            await viewModel.addToPlaylist(song)
                                            await viewModel.saveRecentSearch(song)
                                            viewModel.showSearch = false
                                        }
                                    }
                                }
                            }
                            .frame(minWidth: 300, minHeight: 500)
                        }
                    }
                    .padding()
                }
            )
#endif
        }
        .onAppear {
            viewModel.getSongs()
            viewModel.setupDebounce()
            Task {
                await viewModel.getRecentSearch()
            }
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
