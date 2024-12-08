//
//  PlaylistDefaultLocalDataSource.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 08/12/24.
//

import Combine
import Foundation
import SwiftData

final class PlaylistDefaultLocalDataSource: PlaylistLocalDataSource {
    let manager: PersistentManager
    
    init(manager: PersistentManager = PersistentManager.shared) {
        self.manager = manager
    }
    
    @MainActor
    func getPlaylists() async throws -> [Playlist] {
        let playlists = try manager.modelContainer.mainContext.fetch(FetchDescriptor<Playlist>())
        
        return playlists
    }
    
    @MainActor
    func getsongFromPlaylist(_ playlist: Playlist) async throws -> [Song] {
        let playlists = try manager.modelContainer.mainContext.fetch(FetchDescriptor<Playlist>())
        guard let playlist = playlists.first(where: {
            $0 == playlist
        }) else { return [] }
        
        return playlist.songs
    }
    
    @MainActor
    func savePlaylist(_ playlist: Playlist) async throws {
        let context = manager.modelContainer.mainContext
        
        context.insert(playlist)
        try context.save()
    }
    
    @MainActor
    func deletePlaylist(_ playlist: Playlist) async throws {
        let context = manager.modelContainer.mainContext
        
        context.delete(playlist)
        try context.save()
    }
    
    @MainActor
    func addSongToPlaylist(_ playlist: Playlist, song: Song) async throws {
        let context = manager.modelContainer.mainContext
        
        playlist.songs.append(contentsOf: [song])
        
        context.insert(playlist)
        try context.save()
    }
    
    @MainActor
    func deleteSongFromPlaylist(song: Song) async throws {
        let context = manager.modelContainer.mainContext
        
        context.delete(song)
        try context.save()
    }
}
