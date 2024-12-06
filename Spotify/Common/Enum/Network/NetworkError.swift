//
//  NetworkError.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(code: Int, msg: String)
}
