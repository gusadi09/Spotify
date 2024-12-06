//
//  ContentView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        Group {
#if os(iOS)
            if UIDevice.current.userInterfaceIdiom == .pad {
                NavigationSplitView {
                    MainSidebarView(selectedSection: $viewModel.selectedSection, headerName: "John Doe") {}
                } detail: {
                    Group {
                        switch viewModel.selectedSection {
                        case .library:
                            LibraryView()
                        case .search:
                            Text("Search")
                        case .home:
                            Text(Localizable.home)
                        }
                    }
                }
                .tint(colorScheme == .dark ? .white : .black)
                
            } else {
                NavigationStack {
                    TabView(
                        selection: $viewModel.selectedSection
                    ) {
                        Tab(
                            value: TabSection.home
                        ) {
                            Text(Localizable.home)
                        } label: {
                            VStack {
                                (
                                    viewModel.selectedSection == .home
                                    ? Image.Icons.homeFill
                                    : Image.Icons.home
                                )
                                .renderingMode(.template)
                                
                                Text(Localizable.home)
                            }
                        }
                        
                        Tab(
                            value: TabSection.search
                        ) {
                            Text("Search")
                        } label: {
                            VStack {
                                Image.Icons.search
                                    .renderingMode(.template)
                                
                                Text("Search")
                            }
                        }
                        
                        Tab(
                            value: TabSection.library
                        ) {
                            Text(Localizable.library)
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
                                                    
                                                    Text(Localizable.yourLibrary)
                                                        .font(.avenirNextDemi(size: 24))
                                                        .padding(.horizontal, 4)
                                                }
                                            }
                                        )
                                    }
                                }
                        } label: {
                            VStack {
                                Image.Icons.library
                                    .renderingMode(.template)
                                
                                Text(Localizable.library)
                            }
                        }
                    }
                }
                .tint(colorScheme == .dark ? .white : .black)
            }
#elseif os(macOS)
            NavigationSplitView {
                MainSidebarView(selectedSection: $viewModel.selectedSection, headerName: "John Doe") {}
            } detail: {
                Group {
                    switch viewModel.selectedSection {
                    case .library:
                        LibraryView()
                    case .search:
                        Text("Search")
                    case .home:
                        Text(Localizable.home)
                    }
                }
            }
            .tint(colorScheme == .dark ? .white : .black)
#endif
        }
        .tint(.white)
    }
}

#Preview {
    MainView()
        .modelContainer(for: Item.self, inMemory: true)
}
