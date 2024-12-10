//
//  Localizable.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import Foundation

enum Localizable {
    enum Network {
        static let networkError = String(localized: "network_error")
    }
    
    static let home = String(localized: "Home")
    static let library = String(localized: "Library")
    static let search = String(localized: "Search")
    static let yourLibrary = String(localized: "Your Library")
    static let playlist = String(localized: "Playlist")
    static let playlistSubtitle = String(localized: "playlist_subtitle")
    static let addPlaylistTitle = String(localized: "add_playlist_title")
    static let confirm = String(localized: "confirm")
    static func playlistCountSubtitle(_ count: Int) -> String {
        String(format: String(localized: "playlist_count_subtitle"), count)
    }
    static func songsCount(_ count: Int) -> String {
        String(format: String(localized: "songs_count"), count)
    }
    static let cancel = String(localized: "Cancel")
    static let recentSearches = String(localized: "Recent searches")
    static func songArtist(_ artist: String) -> String {
        String(format: String(localized: "Song • %@"), artist)
    }
}
