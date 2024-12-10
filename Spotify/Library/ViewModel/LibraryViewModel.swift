//
//  LibraryViewModel.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import Foundation
import SwiftUI

final class LibraryViewModel: ObservableObject {
    private let localDataSource: PlaylistLocalDataSource
    
    @Published var currentContentType: ContentType = .noOption
    @Published var currentListType: ListType = .list
    @Published var contentTypes: [ContentType] = [.playlists]
    @Published var isShowingMenu = false
    @Published var isShowingForm = false
    @Published var playlistName: String = ""
    @Published var playlists: [Playlist] = []
    @Published var selectedPlaylist: Playlist?
    
    init(localDataSource: PlaylistLocalDataSource = PlaylistDefaultLocalDataSource()) {
        self.localDataSource = localDataSource
    }
    
    func changeListType() {
        currentListType = currentListType == .list ? .grid : .list
    }
    
    func calculateColumns(for width: CGFloat) -> Int {
        let itemWidth: CGFloat = 100
        let spacing: CGFloat = 10
        let totalSpace = width + spacing
        
        return max(1, Int(totalSpace / (itemWidth + spacing)))
    }
    
    func currentListTypeIcon() -> Image {
        switch currentListType {
        case .grid:
            return Image.Icons.list
        case .list:
            return Image.Icons.grid
        }
    }
    
    func onMenuButtonTap() {
        isShowingMenu.toggle()
    }
    
    func onCreatePlaylistButtonTap() {
        isShowingMenu = false
        isShowingForm = true
    }
    
    func onCloseFormTap() {
        isShowingForm = false
    }
    
    @MainActor
    func addPlaylist() async {
        guard !playlistName.isEmpty else { return }
        let playlist = Playlist.init(id: UUID(), timestamp: Date(), playlistName: playlistName, songs: [])
        
        do {
            try await localDataSource.savePlaylist(playlist)
            playlistName = ""
            isShowingForm = false
            isShowingMenu = false
            await getPlaylists()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func getPlaylists() async {
        do {
            playlists = try await localDataSource.getPlaylists()
        } catch {
            print(error.localizedDescription)
        }
    }
}
