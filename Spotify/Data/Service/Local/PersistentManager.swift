//
//  PersistentManager.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 08/12/24.
//

import Foundation
import SwiftData

class PersistentManager {
    static let shared = PersistentManager()
    
    var modelContainer: ModelContainer = {
        let schema = Schema([
            Playlist.self,
            Song.self,
            RecentSearchSong.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
