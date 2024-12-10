//
//  LibraryViewModel.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import Foundation
import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var selectedSection: TabSection = .library
}
