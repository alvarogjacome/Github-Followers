//
//  GFTabBarViewController.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 18/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

final class GFTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [createSearchNC(), createFavoritesNC()]
        UITabBar.appearance().tintColor = .systemGreen
    }

    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        return UINavigationController(rootViewController: searchVC)
    }

    private func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavoritesListViewController()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        return UINavigationController(rootViewController: favoritesVC)
    }
}
