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

    var body: some View {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad {
            NavigationSplitView {
                VStack {
                    
                }
            } detail: {
                Text("Details")
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
}

#Preview {
    LibraryView()
        .modelContainer(for: Item.self, inMemory: true)
}
