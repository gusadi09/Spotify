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
                    Text("")
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
