//
//  Image+Ext.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI

extension Image {
    enum Icons {
        static let search = Image(.searchIcon)
        static let grid = Image(.gridIcon)
        static let list = Image(.listIcon)
        static let home = Image(.homeIcon)
        static let homeFill = Image(.homeFillIcon)
        static let plus = Image(.plusIcon)
        static let library = Image(.libraryIcon)
        static let playlistSheet = Image(.playlistSheetIcon)
        static let back = Image(.backIcon)
    }
    
    enum Dummy {
        static let profile = Image(.dummyProfileImg)
    }
}
