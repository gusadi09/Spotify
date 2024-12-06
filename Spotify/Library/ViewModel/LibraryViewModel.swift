//
//  LibraryViewModel.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import Foundation

final class LibraryViewModel: ObservableObject {
    @Published var selectedSection: TabSection = .library
}
