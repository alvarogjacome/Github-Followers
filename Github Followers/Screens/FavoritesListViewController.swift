//
//  FavoritesListViewController.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 05/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

class FavoritesListViewController: UIViewController {
    let tableView = UITableView()
    var favorites: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseID)
    }

    private func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let followers):
                if followers.isEmpty {
                    self.showEmptyStateView(with: "Ther are no favorite users \n Add one on the followers screen", in: self.view)
                } else {
                    self.favorites = followers
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentGFAlertViewController(title: "Something went wrong", message: error.rawValue, textButton: "OK")
            }
        }
    }
}

extension FavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseID) as! FavoriteTableViewCell
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destinationViewController = FollowersListViewController(username: favorite.login)
        navigationController?.pushViewController(destinationViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentGFAlertViewController(title: "Unable to remove", message: error.rawValue, textButton: "OK")
        }

        if favorites.isEmpty {
            showEmptyStateView(with: "Ther are no favorite users \n Add one on the followers screen", in: view)
        }
    }
}
