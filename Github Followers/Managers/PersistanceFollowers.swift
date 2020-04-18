//
//  PersistanceFollowers.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 18/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import Foundation

enum persistenceActionType {
    case add, remove
}

enum PersistenceManager {
    private static let defaults = UserDefaults.standard

    enum keys: String {
        case favorites
    }

    static func updateWith(favorite: Follower, actionType: persistenceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrieveFavorites = favorites

                switch actionType {
                case .add:
                    guard !retrieveFavorites.contains(favorite) else {
                        completed(.alreadySaved)
                        return
                    }
                    retrieveFavorites.append(favorite)

                case .remove:
                    retrieveFavorites.removeAll {
                        $0.login == favorite.login
                    }
                }
                completed(saveFavorites(favorites: retrieveFavorites))

            case .failure(let error):
                completed(error)
            }
        }
    }

    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: keys.favorites.rawValue) as? Data else {
            completed(.success([]))
            return
        }
        do {
            completed(.success(try JSONDecoder().decode([Follower].self, from: favoritesData)))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }

    private static func saveFavorites(favorites: [Follower]) -> GFError? {
        do {
            try defaults.set(JSONEncoder().encode(favorites), forKey: keys.favorites.rawValue)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
