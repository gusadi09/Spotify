//
//  LibraryMacOSView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 07/12/24.
//

import SwiftUI

struct LibraryMacOSView: View {
    @ObservedObject var viewModel: LibraryViewModel
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
        .navigationTitle(Text(Localizable.yourLibrary))
    }
}

#Preview {
    GeometryReader { geo in
        LibraryMacOSView(viewModel: LibraryViewModel(), geo: geo)
    }
}
