//
//  GFFollowerViewController.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 17/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

class GFFollowerViewController: GFItemInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }

    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
