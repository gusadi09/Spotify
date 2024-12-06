//
//  LibraryView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI

struct LibraryView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel = LibraryViewModel()
    var body: some View {
        GeometryReader { geo in
#if os(iOS)
            if UIDevice.current.userInterfaceIdiom == .pad {
                VStack {
                    List {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyVStack {
                                CapsuleView(current: $viewModel.currentContentType, .playlists)
                                    .onTapGesture {
                                        viewModel.selectContentType(.playlists)
                                    }
                            }
                            .padding()
                        }
                        .listRowSeparator(.hidden)
                        
                        HStack {
                            Spacer()
                            
                            Button(
                                action: {
                                    viewModel.changeListType()
                                }, label: {
                                    switch viewModel.currentListType {
                                    case .grid:
                                        Image.Icons.list
                                            .renderingMode(.template)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16)
                                    case .list:
                                        Image.Icons.grid
                                            .renderingMode(.template)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16)
                                    }
                                }
                            )
                        }
                        .listRowSeparator(.hidden)
                        
                        switch viewModel.currentListType {
                        case .list:
                            ForEach(0..<100) { _ in
                                LibraryPlaylistItemView()
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
                                ForEach(0..<100) { _ in
                                    LibraryPlaylistGridItemView()
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                .buttonStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(
                            action: {
                                
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
                .navigationTitle(Text("Your Library"))
            } else {
                VStack {
                    List {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyVStack {
                                CapsuleView(current: $viewModel.currentContentType, .playlists)
                                    .onTapGesture {
                                        viewModel.selectContentType(.playlists)
                                    }
                            }
                            .padding()
                        }
                        .listRowSeparator(.hidden)
                        
                        HStack {
                            Spacer()
                            
                            Button(
                                action: {
                                    viewModel.changeListType()
                                }, label: {
                                    switch viewModel.currentListType {
                                    case .grid:
                                        Image.Icons.list
                                            .renderingMode(.template)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16)
                                    case .list:
                                        Image.Icons.grid
                                            .renderingMode(.template)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16)
                                    }
                                }
                            )
                        }
                        .listRowSeparator(.hidden)
                        
                        switch viewModel.currentListType {
                        case .list:
                            ForEach(0..<100) { _ in
                                LibraryPlaylistItemView()
                                    .listRowSeparator(.hidden)
                            }
                        case .grid:
                            LazyVGrid(
                                columns: Array(
                                    repeating: GridItem(.flexible(), spacing: 10),
                                    count: viewModel.calculateColumns(for: geo.size.width/1.3)
                                ),
                                spacing: 10
                            ) {
                                ForEach(0..<100) { _ in
                                    LibraryPlaylistGridItemView()
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                .buttonStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(
                            action: {},
                            label: {
                                HStack {
                                    Image.Dummy.profile
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 35)
                                        .clipShape(Circle())
                                    
                                    Text("Your Library")
                                        .font(.avenirNextDemi(size: 24))
                                        .padding(.horizontal, 4)
                                }
                            }
                        )
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(
                            action: {
                                
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
            }
#elseif os(macOS)
            VStack {
                List {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyVStack {
                            CapsuleView(current: $viewModel.currentContentType, .playlists)
                                .onTapGesture {
                                    viewModel.selectContentType(.playlists)
                                }
                        }
                        .padding()
                    }
                    .listRowSeparator(.hidden)
                    
                    HStack {
                        Spacer()
                        
                        Button(
                            action: {
                                viewModel.changeListType()
                            }, label: {
                                switch viewModel.currentListType {
                                case .grid:
                                    Image.Icons.list
                                        .renderingMode(.template)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16)
                                case .list:
                                    Image.Icons.grid
                                        .renderingMode(.template)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16)
                                }
                            }
                        )
                    }
                    .listRowSeparator(.hidden)
                    
                    switch viewModel.currentListType {
                    case .list:
                        ForEach(0..<100) { _ in
                            LibraryPlaylistItemView()
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
                            ForEach(0..<100) { _ in
                                LibraryPlaylistGridItemView()
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .buttonStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(
                        action: {
                            
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
            .navigationTitle(Text("Your Library"))
#endif
        }
    }
}

#Preview {
    @Previewable @Environment(\.colorScheme) var colorScheme
#if os(iOS)
    if UIDevice.current.userInterfaceIdiom == .pad {
        NavigationSplitView {
            
        } detail: {
            LibraryView()
                .preferredColorScheme(.dark)
        }
        .tint(colorScheme == .dark ? .white : .black)
    } else {
        NavigationStack {
            LibraryView()
                .preferredColorScheme(.dark)
        }
        .tint(colorScheme == .dark ? .white : .black)
    }
#elseif os(macOS)
    NavigationSplitView {
        
    } detail: {
        LibraryView()
            .preferredColorScheme(.dark)
    }
#endif
}
