//
//  ImageLoader.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 09/12/24.
//

import SwiftUI

struct ImageLoader: View {
    let url: URL?
    let height: CGFloat?
    let width: CGFloat?
    
    init(url: URL?, height: CGFloat? = nil, width: CGFloat? = nil) {
        self.url = url
        self.height = height
        self.width = width
    }
    
    var body: some View {
        AsyncImage(
            url: url
        ) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)

            case .failure:
                Rectangle()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .overlay(
                        Image(systemName: "record.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: width == nil ? width : (width ?? 0)/2,
                                height: height == nil ? height : (height ?? 0)/2
                            )
                            .foregroundStyle(.background)
                    )

            case .empty:
                Rectangle()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .overlay(
                        ProgressView()
                            .progressViewStyle(.circular)
                            .foregroundStyle(.background)
                    )

            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    ImageLoader(url: nil, height: 30, width: 30)
}
