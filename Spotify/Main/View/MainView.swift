//
//  ContentView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
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
                            Text("Details")
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
                        case .search:
                            Text("Search")
                        case .home:
                            Text("Home")
                        }
                    }
                }
                
            } else {
                NavigationStack {
                    TabView(
                        selection: $viewModel.selectedSection
                    ) {
                        Tab(
                            value: TabSection.home
                        ) {
                            Text("Home")
                        } label: {
                            VStack {
                                (
                                    viewModel.selectedSection == .home
                                    ? Image.Icons.homeFill
                                    : Image.Icons.home
                                )
                                .renderingMode(.template)
                                
                                Text("Home")
                            }
                            .tint(
                                viewModel.selectedSection == .home
                                ? .white
                                : .gray
                            )
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
                            .tint(
                                viewModel.selectedSection == .search
                                ? .white
                                : .gray
                            )
                        }
                        
                        Tab(
                            value: TabSection.library
                        ) {
                            Text("Library")
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
                                                    
                                                    Text("Your Library")
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
                                
                                Text("Library")
                            }
                            .tint(
                                viewModel.selectedSection == .library
                                ? .white
                                : .gray
                            )
                        }
                    }
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
    MainView()
        .modelContainer(for: Item.self, inMemory: true)
}
