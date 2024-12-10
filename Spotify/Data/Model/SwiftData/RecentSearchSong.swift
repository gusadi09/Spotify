//
//  RecentSearchSong.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 09/12/24.
//

import Foundation
import SwiftData

@Model
final class RecentSearchSong {
    @Attribute(.unique) var id: Int
    @Attribute var artistName: String
    @Attribute var artworkUrl30: URL?
    @Attribute var artworkUrl60: URL?
    @Attribute var artworkUrl100: URL?
    @Attribute var trackName: String
    
    init(id: Int, artistName: String, artworkUrl30: URL?, artworkUrl60: URL?, artworkUrl100: URL?, trackName: String) {
        self.id = id
        self.artistName = artistName
        self.artworkUrl30 = artworkUrl30
        self.artworkUrl60 = artworkUrl60
        self.artworkUrl100 = artworkUrl100
        self.trackName = trackName
    }
}
