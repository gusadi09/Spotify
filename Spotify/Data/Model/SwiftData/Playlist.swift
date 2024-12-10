//
//  Item.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import Foundation
import SwiftData

@Model
final class Playlist {
    @Attribute(.unique) var id: UUID
    @Attribute var timestamp: Date
    @Attribute var playlistName: String
    @Relationship(deleteRule: .cascade, inverse: \Song.playlist) var songs: [Song]
    
    init(id: UUID, timestamp: Date, playlistName: String, songs: [Song]) {
        self.id = id
        self.timestamp = timestamp
        self.playlistName = playlistName
        self.songs = songs
    }
}
