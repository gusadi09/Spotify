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
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
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
                        Text(Localizable.search)
                    case .home:
                        Text(Localizable.home)
                    }
                }
            }
            .tint(colorScheme == .dark ? .white : .black)
            
        } else {
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
                    Text(Localizable.search)
                } label: {
                    VStack {
                        Image.Icons.search
                            .renderingMode(.template)
                        
                        Text(Localizable.search)
                    }
                }
                
                Tab(
                    value: TabSection.library
                ) {
                    NavigationStack {
                        LibraryView()
                    }
                } label: {
                    VStack {
                        Image.Icons.library
                            .renderingMode(.template)
                        
                        Text(Localizable.library)
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
                    Text(Localizable.search)
                case .home:
                    Text(Localizable.home)
                }
            }
            
        }
        .tint(colorScheme == .dark ? .white : .black)
#endif
    }
}

#Preview {
    MainView()
}
