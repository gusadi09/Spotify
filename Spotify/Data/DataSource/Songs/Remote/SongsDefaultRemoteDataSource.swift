//
//  SongsDefaultRemoteDataSource.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 08/12/24.
//

import Combine
import Foundation

final class SongsDefaultRemoteDataSource: SongsRemoteDataSource {
    
    let service: NetworkManager
    
    init(service: NetworkManager = DefaultNetworkManager()) {
        self.service = service
    }
    
    func fetchSongs(with query: String) -> AnyPublisher<SongResponse, NetworkError> {
        let body = [
            "search" : query,
            "media" : "music"
        ]
        
        return self.service.request(
            path: "/search",
            header: nil,
            method: .get,
            body: body.toJSONData(),
            responseType: SongResponse.self
        )
    }
}
