//
//  FavoriteTableViewCell.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 18/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    static let reuseID = "FavoriteCell"

    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let userNameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(favorite: Follower) {
        userNameLabel.text = favorite.login
        avatarImageView.loadImage(from: favorite.avatarUrl)
    }

    private func configure() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)

        accessoryType = .disclosureIndicator

        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),

            userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            userNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
