//
//  LibraryViewModel.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import Foundation

final class LibraryViewModel: ObservableObject {
    @Published var currentContentType: ContentType = .noOption
    @Published var currentListType: ListType = .list
    
    func selectContentType(_ listType: ContentType) {
        currentContentType = currentContentType == listType ? .noOption : listType
    }
    
    func changeListType() {
        currentListType = currentListType == .list ? .grid : .list
    }
    
    func calculateColumns(for width: CGFloat) -> Int {
        let itemWidth: CGFloat = 100
        let spacing: CGFloat = 10
        let totalSpace = width + spacing
        
        return max(1, Int(totalSpace / (itemWidth + spacing)))
    }
}
