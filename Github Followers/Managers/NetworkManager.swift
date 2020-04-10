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

    func getFollowers(username: String, page: Int, completionHandler: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseURL + "\(username)/followers?page=\(page)&per_page=100"

        guard let url = URL(string: endpoint) else {
            completionHandler(nil, "This username created an invalid request. Please try again")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completionHandler(nil, "Unable to complete your request. Please check your internet connection")
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, "Invalid response from the server. Please try again.")
                return
            }

            guard let data = data else {
                completionHandler(nil, "The data received form de server was invalid. Please try again.")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)

                completionHandler(followers, nil)
            } catch {}

        }.resume()
    }
}
