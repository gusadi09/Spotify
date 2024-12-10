//
//  NetworkManage.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import Combine
import Foundation

protocol NetworkManager {
    func request<T: Codable>(path: String, header: [String: String]?, method: NetworkMethod, body: [String:String]?, responseType: T.Type, bodyType: NetworkBodyType) -> AnyPublisher<T, NetworkError>
}
