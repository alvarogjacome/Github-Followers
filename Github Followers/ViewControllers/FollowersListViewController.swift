//
//  FollowersListViewController.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 06/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

class FollowersListViewController: UIViewController {
    enum Section {
        case main
    }

    var username: String!
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    private var followers: [Follower]!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCollectionView()
        getFollowers()
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

    private func getFollowers() {
        NetworkManager.shared.getFollowers(username: username, page: 1) {
            switch $0 {
            case .failure(let error):
                self.presentGFAlertViewController(title: "Something went wrong", message: error.rawValue, textButton: "OK")
            case .success(let followers):
                self.followers = followers
                self.updateData()
            }
        }
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: threeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID)
    }

    private func threeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let viewWidth = view.bounds.width
        let padding: CGFloat = 12
        let availableSpace = viewWidth - (padding * 4)
        let itemWidth = availableSpace / 3

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.1)

        return flowLayout
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexPath) as! FollowerCollectionViewCell
            cell.set(follower: follower)
            return cell
        })
    }

    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
