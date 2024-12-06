//
//  ContentView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI
import SwiftData

struct LibraryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @ObservedObject var viewModel = LibraryViewModel()

    var body: some View {
        Group {
#if os(iOS)
            if UIDevice.current.userInterfaceIdiom == .pad {
                NavigationSplitView {
                    ScrollView {
                        Button(
                            action: {
                                viewModel.selectedSection = .home
                            }, label: {
                                HStack(alignment: .center) {
                                    (
                                        viewModel.selectedSection == .home
                                        ? Image.Icons.homeFill
                                        : Image.Icons.home
                                    )
                                        .renderingMode(.template)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18)
                                    
                                    Text("Home")
                                        .font(
                                            viewModel.selectedSection == .home
                                            ? .avenirNextDemi(size: 16)
                                            :.avenirNextRegular(size: 16)
                                        )
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 10)
                                .contentShape(Rectangle())
                            }
                        )
                        .tint(viewModel.selectedSection == .home ? .white : .gray)
                        .padding(.top)
                        
                        Button(
                            action: {
                                viewModel.selectedSection = .search
                            }, label: {
                                HStack(alignment: .center) {
                                    Image.Icons.search
                                        .renderingMode(.template)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18)
                                    
                                    Text("Search")
                                        .font(
                                            viewModel.selectedSection == .search
                                            ? .avenirNextDemi(size: 16)
                                            :.avenirNextRegular(size: 16)
                                        )
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 10)
                                .contentShape(Rectangle())
                            }
                        )
                        .tint(viewModel.selectedSection == .search ? .white : .gray)
                        
                        Button(
                            action: {
                                viewModel.selectedSection = .library
                            }, label: {
                                HStack(alignment: .center) {
                                    Image.Icons.library
                                        .renderingMode(.template)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18)
                                    
                                    Text("Library")
                                        .font(
                                            viewModel.selectedSection == .library
                                            ? .avenirNextDemi(size: 16)
                                            :.avenirNextRegular(size: 16)
                                        )
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 10)
                                .contentShape(Rectangle())
                            }
                        )
                        .tint(viewModel.selectedSection == .library ? .white : .gray)
                    }
                    .padding()
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
                                            .frame(height: 55)
                                            .clipShape(Circle())
                                        
                                        Text("John Doe")
                                            .font(.avenirNextBold(size: 18))
                                            .padding(.horizontal, 4)
                                    }
                                }
                            )
                        }
                    }
                } detail: {
                    Group {
                        switch viewModel.selectedSection {
                        case .library:
                            Text("Details")
                                .toolbar {
                                    ToolbarItem(placement: .topBarTrailing) {
                                        Button(
                                            action: {
                                                
                                            },
                                            label: {
                                                Image.Icons.plus
                                                    .renderingMode(.template)
                                            }
                                        )
                                    }
                                }
                        case .search:
                            Text("Search")
                        case .home:
                            Text("Home")
                        }
                    }
                    .navigationTitle(Text("Your Library"))
                }
                
            } else {
                NavigationStack {
                    Text("iOS")
                }
            }
#elseif os(macOS)
            NavigationSplitView {
                Text("macOS")
            } detail: {
                Text("Detail")
            }
#endif
        }
        .preferredColorScheme(.dark)
        .tint(.white)
    }
}

#Preview {
    LibraryView()
        .modelContainer(for: Item.self, inMemory: true)
}
