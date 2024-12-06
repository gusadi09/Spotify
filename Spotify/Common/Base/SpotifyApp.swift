//
//  SpotifyApp.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI
import SwiftData

@main
struct SpotifyApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear {
                    registerCustomFonts(font: "AvenirNextLTPro-Regular")
                    registerCustomFonts(font: "AvenirNextLTPro-Demi")
                    registerCustomFonts(font: "AvenirNextLTPro-Bold")
                }
        }
        .modelContainer(sharedModelContainer)
    }
    
    func registerCustomFonts(font: String) {
            guard let fontURL = Bundle.main.url(forResource: font, withExtension: "ttf") else {
                print("Failed to find font file in bundle.")
                return
            }

            var error: Unmanaged<CFError>?
            CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error)

            if let error = error?.takeUnretainedValue() {
                print("Failed to register font: \(error.localizedDescription)")
            } else {
                print("Font registered successfully!")
            }
        }
}
