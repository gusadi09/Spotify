//
//  NetworkManager.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import Combine
import Foundation

final class DefaultNetworkManager: NetworkManager {
    
    private let baseUrl = "https://itunes.apple.com"
    func request<T: Codable>(path: String, header: [String: String]? = nil, method: NetworkMethod, body: Encodable? = nil, responseType: T.Type) -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: baseUrl + path) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header
        
        if let body = body {
            request.httpBody = body.toJSONData()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.serverError(code: (output.response as? HTTPURLResponse)?.statusCode ?? -1, msg: Localizable.Network.networkError)
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return NetworkError.serverError(code: -1, msg: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
