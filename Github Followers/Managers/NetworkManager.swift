//
//  NetworkManager.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 10/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()

    func getFollowers(username: String, page: Int, completionHandler: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?page=\(page)&per_page=100"

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

    func getUser(username: String, completionHandler: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = baseURL + "\(username)"

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
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completionHandler(.success(user))
            } catch {
                completionHandler(.failure(.invalidData))
            }

        }.resume()
    }

    func downloadImage(from url: String, completed: @escaping (UIImage?) -> Void) {
        let urlString = NSString(string: url)

        if let cachedImage = cache.object(forKey: urlString) {
            completed(cachedImage)
            return
        }

        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)
            else { return }

            self.cache.setObject(image, forKey: urlString)
            DispatchQueue.main.async {
                completed(image)
            }

            }).resume()
    }
}
