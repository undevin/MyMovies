//
//  URLSession-Codable.swift
//  MyMovies
//
//  Created by Devin on 5/23/21.
//

import Combine
import Foundation

extension URLSession {
    func fetch<T: Decodable>(_ url: URL, defaultValue: T, completion: @escaping (T) -> Void) -> AnyCancellable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return self.dataTaskPublisher(for: url)
            .retry(1)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .replaceError(with: defaultValue)
            .receive(on: RunLoop.main)
            .sink(receiveValue: completion)
    }
    
    func get<T: Decodable>(path: String, queryItems: [String: String] = [:], defaultValue: T, completion: @escaping (T) -> Void) -> AnyCancellable? {
        guard var components = URLComponents(string: "https://api.themoviedb.org/3/\(path)") else { return nil }
        
        components.queryItems = [URLQueryItem(name: "api_key", value: "41940113fa128b1a98e3efe6e275debb")] + queryItems.map(URLQueryItem.init)
        if let url = components.url {
            print(url)
            return fetch(url, defaultValue: defaultValue, completion: completion)
        } else {
            return nil
        }
    }
    
    func post<T: Encodable>(_ data: T, to url: URL, completion: @escaping (String) -> Void) -> AnyCancellable {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(data)
        
        return dataTaskPublisher(for: request)
            .map { data, response in
                String(decoding: data, as: UTF8.self)
            }
            .replaceError(with: "Decode Error")
            .receive(on: RunLoop.main)
            .sink(receiveValue: completion)
    }
}//End of Extension
