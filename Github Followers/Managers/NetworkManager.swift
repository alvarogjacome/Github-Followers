//
//  NetworkManager.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 10/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"

    func getFollowers(username: String, page: Int, completionHandler: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?page=\(page)&per_page=99"

        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.invalidRequest))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completionHandler(.success(followers))
            } catch {
                completionHandler(.failure(.invalidData))
            }

        }.resume()
    }
}
