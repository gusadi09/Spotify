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
    private let manager: PersistentManager
    
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
    
    @MainActor
    func saveRecentSongSearch(_ song: RecentSearchSong) async throws {
        let context = manager.modelContainer.mainContext
        
        context.insert(song)
        try context.save()
    }
    
    @MainActor
    func getPlaylist(with id: UUID) async throws -> Playlist {
        let predicate = #Predicate<Playlist> { $0.id == id }
        let playlists = try manager.modelContainer.mainContext.fetch(FetchDescriptor<Playlist>(predicate: predicate))
        
        return playlists.first ?? Playlist(id: UUID(), timestamp: Date(), playlistName: "", songs: [])
    }
    
    @MainActor
    func getRecentSearchSongs() async throws -> [RecentSearchSong] {
        let songs = try manager.modelContainer.mainContext.fetch(FetchDescriptor<RecentSearchSong>())
        
        return songs
    }
}
