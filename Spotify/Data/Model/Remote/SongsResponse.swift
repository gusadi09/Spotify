//
//  SongReponse.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 08/12/24.
//

import Foundation

struct SongResponse: Codable {
    let resultCount: Int?
    let results: [SongData]?
    
    init(resultCount: Int?, results: [SongData]?) {
        self.resultCount = resultCount
        self.results = results
    }
}

struct SongData: Codable {
    let trackId: Int?
    let artistName: String?
    let artworkUrl30: URL?
    let artworkUrl60: URL?
    let artworkUrl100: URL?
    let trackName: String?
    
    init(trackId: Int?, artistName: String?, artworkUrl30: URL?, artworkUrl60: URL?, artworkUrl100: URL?, trackName: String?) {
        self.trackId = trackId
        self.artistName = artistName
        self.artworkUrl30 = artworkUrl30
        self.artworkUrl60 = artworkUrl60
        self.artworkUrl100 = artworkUrl100
        self.trackName = trackName
    }
    
    func convert(with playlist: Playlist?) -> Song {
        Song(
            id: self.trackId ?? 0,
            artistName: self.artistName ?? "",
            artworkUrl30: self.artworkUrl30,
            artworkUrl60: self.artworkUrl60,
            artworkUrl100: self.artworkUrl100,
            trackName: self.trackName ?? "",
            playlist: playlist
        )
    }
}
