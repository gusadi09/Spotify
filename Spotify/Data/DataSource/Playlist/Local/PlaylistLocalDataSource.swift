//
//  PlaylistLocalDataSource.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 08/12/24.
//

import Foundation

protocol PlaylistLocalDataSource {
    func savePlaylist(_ playlist: Playlist) async throws
    func deletePlaylist(_ playlist: Playlist) async throws
    func getPlaylists() async throws -> [Playlist]
    func getsongFromPlaylist(_ playlist: Playlist) async throws -> [Song]
    func addSongToPlaylist(_ playlist: Playlist, song: Song) async throws
    func deleteSongFromPlaylist(song: Song) async throws
}
