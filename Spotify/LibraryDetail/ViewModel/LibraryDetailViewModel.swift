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
    @Published var countedSongs: Int = 0
    @Published var isError = false
    @Published var errorMsg: String?
    
    init(
        remote: SongsRemoteDataSource = SongsDefaultRemoteDataSource(),
        local: PlaylistLocalDataSource = PlaylistDefaultLocalDataSource(),
        playlist: Playlist
    ) {
        self.remote = remote
        self.local = local
        self.playlist = playlist
    }
    
    @MainActor
    func onSelectSong(with song: SongData) {
        Task {
            await addToPlaylist(song)
            await saveRecentSearch(song)
            
            showSearch = false
        }
    }
    
    func onAppear() {
        countedSongs = playlist.songs.count
        getSongs()
        setupDebounce()
        Task {
            await getRecentSearch()
        }
    }
    
    func toggleSearchSheet() {
        showSearch.toggle()
    }
    
    func resetSearch() {
        searchSong = ""
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
                    break
                case .failure(let error):
                    DispatchQueue.main.async { [weak self] in
                        self?.isError = true
                        self?.errorMsg = error.localizedDescription
                    }
                }
            } receiveValue: { response in
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
            isError = true
            errorMsg = error.localizedDescription
        }
    }
    
    @MainActor
    func addToPlaylist(_ song: SongData) async {
        if playlist.songs.contains(where: { $0.id == song.trackId }) {
            isError = true
            errorMsg = Localizable.duplicatedSong
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
                countedSongs = playlist.songs.count
            } catch {
                isError = true
                errorMsg = error.localizedDescription
            }
        }
    }
    
    @MainActor
    func getRecentSearch() async {
        do {
            recentSearchs = try await local.getRecentSearchSongs()
        } catch {
            isError = true
            errorMsg = error.localizedDescription
        }
    }
}
