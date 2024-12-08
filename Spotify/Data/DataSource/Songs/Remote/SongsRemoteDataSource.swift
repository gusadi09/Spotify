//
//  SongsRemoteDataSource.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 08/12/24.
//

import Combine
import Foundation

protocol SongsRemoteDataSource {
    func fetchSongs(with query: String) -> AnyPublisher<SongResponse, NetworkError>
}
