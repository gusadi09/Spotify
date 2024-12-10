//
//  LibraryDetailViewModel.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 09/12/24.
//

import Combine
import Foundation

final class LibraryDetailViewModel: ObservableObject {
    
    private let remote: SongsRemoteDataSource
    private let local: PlaylistLocalDataSource
    private var cancellables: Set<AnyCancellable> = []
    @Published var playlist: Playlist
    @Published var songs: [SongData] = []
    @Published var recentSearchs: [RecentSearchSong] = []
    @Published var showSearch = false
    @Published var searchSong: String = ""
    @Published var debounceSearch: String = ""
    
    init(
        remote: SongsRemoteDataSource = SongsDefaultRemoteDataSource(),
        local: PlaylistLocalDataSource = PlaylistDefaultLocalDataSource(),
        playlist: Playlist
    ) {
        self.remote = remote
        self.local = local
        self.playlist = playlist
    }
    
    func setupDebounce() {
        $searchSong
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] newValue in
                self?.debounceSearch = newValue
                self?.getSongs(with: newValue)
            }
            .store(in: &cancellables)
    }
    
    func getSongs(with query: String = "") {
        remote.fetchSongs(with: query)
            .sink { phase in
                switch phase {
                case .finished:
                    print("completed")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { response in
                print(response)
                DispatchQueue.main.async { [weak self] in
                    self?.songs = response.results ?? []
                }
            }
            .store(in: &cancellables)

        
    }
    
    @MainActor
    func saveRecentSearch(_ song: SongData) async {
        do {
            let song = RecentSearchSong(
                id: song.trackId ?? 0,
                artistName: song.artistName ?? "",
                artworkUrl30: song.artworkUrl30,
                artworkUrl60: song.artworkUrl60,
                artworkUrl100: song.artworkUrl100,
                trackName: song.trackName ?? ""
            )
            
            try await local.saveRecentSongSearch(song)
            await getRecentSearch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func addToPlaylist(_ song: SongData) async {
        if playlist.songs.contains(where: { $0.id == song.trackId }) {
            print("can't add song to playlist")
        } else {
            do {
                let song = Song(
                    id: song.trackId ?? 0,
                    artistName: song.artistName ?? "",
                    artworkUrl30: song.artworkUrl30,
                    artworkUrl60: song.artworkUrl60,
                    artworkUrl100: song.artworkUrl100,
                    trackName: song.trackName ?? "",
                    playlist: playlist
                )
                
                try await local.addSongToPlaylist(playlist, song: song)
                playlist = try await local.getPlaylist(with: playlist.id)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func getRecentSearch() async {
        do {
            recentSearchs = try await local.getRecentSearchSongs()
        } catch {
            print(error.localizedDescription)
        }
    }
}
