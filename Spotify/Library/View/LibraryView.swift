//
//  LibraryView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI

struct LibraryView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = LibraryViewModel()
    var body: some View {
        GeometryReader { geo in
#if os(iOS)
            if UIDevice.current.userInterfaceIdiom == .pad {
                LibrayiPadView(viewModel: viewModel, geo: geo)
            } else {
                LibrayiPhoneView(viewModel: viewModel, geo: geo)
            }
#elseif os(macOS)
            LibraryMacOSView(viewModel: viewModel, geo: geo)
#endif
        }
        .onAppear {
            Task {
                await viewModel.getPlaylists()
            }
        }
        .refreshable {
            await viewModel.getPlaylists()
        }
        .alert(Localizable.attention, isPresented: $viewModel.isError) {
            
        } message: {
            Text(viewModel.errorMsg ?? "")
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
