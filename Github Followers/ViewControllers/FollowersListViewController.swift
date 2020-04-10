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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        NetworkManager.shared.getFollowers(username: username, page: 1) { followers, error in
            guard let followers = followers else {
                self.presentGFAlertViewController(title: "Something went wrong", message: error!, textButton: "OK")
                return
            }
            dump(followers)

        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
