//
//  GFAvatarImageView.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 11/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = UIImage(named: "avatar-placeholder")
        translatesAutoresizingMaskIntoConstraints = false
    }
}
