//
//  FollowersListViewController.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 06/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

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
                self.updateData()
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

    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<UIHelper.Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
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
}
