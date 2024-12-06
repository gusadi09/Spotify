//
//  Item.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
