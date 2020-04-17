//
//  GFItemInfoView.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 17/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repos, gists, following, followers
}

class GFItemInfoView: UIView {
    let symbolImage = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubview(symbolImage)
        addSubview(titleLabel)
        addSubview(countLabel)

        symbolImage.translatesAutoresizingMaskIntoConstraints = false
        symbolImage.contentMode = .scaleAspectFill
        symbolImage.tintColor = .label

        NSLayoutConstraint.activate([
            symbolImage.topAnchor.constraint(equalTo: topAnchor),
            symbolImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImage.widthAnchor.constraint(equalToConstant: 20),
            symbolImage.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.centerYAnchor.constraint(equalTo: symbolImage.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImage.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),

            countLabel.topAnchor.constraint(equalTo: symbolImage.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    func set(itemInfoType: ItemInfoType, with count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImage.image = UIImage(systemName: SFSymbols.repos)
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImage.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Public Gists"
        case .following:
            symbolImage.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        case .followers:
            symbolImage.image = UIImage(systemName: SFSymbols.follower)
            titleLabel.text = "Followers"
        }
        countLabel.text = String(count)
    }
}
