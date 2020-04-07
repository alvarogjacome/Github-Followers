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
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
