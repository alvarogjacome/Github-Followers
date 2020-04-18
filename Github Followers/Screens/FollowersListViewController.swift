//
//  FollowersListViewController.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 06/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

protocol FollowerListViewControllerDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollowersListViewController: UIViewController {
    var username: String!
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<UIHelper.Section, Follower>!
    private var followers: [Follower]!

    private var page = 1
    private var moreFollowers = true

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureSearchBar()
        configureCollectionView()
        getFollowers(page: page)
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }

    private func configureSearchBar() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func getFollowers(page: Int) {
        showLoader()
        NetworkManager.shared.getFollowers(username: username, page: page) { [weak self] in
            guard let self = self else { return }
            self.hideLoader()
            switch $0 {
            case .failure(let error):
                self.presentGFAlertViewController(title: "Something went wrong", message: error.rawValue, textButton: "OK")
            case .success(let followers):
                self.moreFollowers = followers.count < 100
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty { DispatchQueue.main.async { self.showEmptyStateView(with: "The user does not have any followers yet 🥺", in: self.view) } }
                self.updateData(for: followers)
            }
        }
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.threeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID)
        followers = []
        collectionView.delegate = self
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexPath) as! FollowerCollectionViewCell
            cell.set(follower: follower)
            return cell
        })
    }

    private func updateData(for followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<UIHelper.Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    @objc private func addButtonTapped() {
        showLoader()

        NetworkManager.shared.getUser(username: username) { [weak self] result in
            guard let self = self else { return }
            self.hideLoader()
            switch result {
            case .success(let user):
                let follower = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favorite: follower, actionType: .add, completed: { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentGFAlertViewController(title: "Success", message: "This user was saved correctly ❤️", textButton: "Nice!")
                        return
                    }
                    self.presentGFAlertViewController(title: "Oops!", message: error.rawValue, textButton: "OK")

                })
            case .failure(let error):
                self.presentGFAlertViewController(title: "Something went wrong", message: error.rawValue, textButton: "OK")
            }
        }
    }
}

extension FollowersListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset.y
        let height = scrollView.frame.size.height
        let contentHeight = scrollView.contentSize.height

        if offset >= contentHeight - height {
            guard !moreFollowers else { return }
            page += 1
            getFollowers(page: page)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let follower = dataSource.itemIdentifier(for: indexPath) else { return }
        let infoVC = UserInfoViewController()
        infoVC.follower = follower
        infoVC.delegate = self
        let navController = UINavigationController(rootViewController: infoVC)
        present(navController, animated: true)
    }
}

extension FollowersListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        updateData(for: followers.filter { $0.login.lowercased().contains(filter.lowercased()) })
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(for: followers)
    }
}

extension FollowersListViewController: FollowerListViewControllerDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        navigationItem.searchController?.searchBar.text = ""
        collectionView.scrollsToTop = true
        followers.removeAll()
        updateData(for: followers)
        getFollowers(page: page)
    }
}
