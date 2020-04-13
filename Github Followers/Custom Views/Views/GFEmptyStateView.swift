//
//  GFEmptyStateView.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 13/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(message: String) {
        super.init(frame: .zero)
        configure(message: message)
    }

    private func configure(message: String? = nil) {
        let labelView = GFTitleLabel(textAlignment: .center, fontSize: 28)
        let imageView = UIImageView(image: UIImage(named: "empty-state-logo"))

        addSubview(imageView)
        addSubview(labelView)

        labelView.numberOfLines = 3
        labelView.textColor = .secondaryLabel
        labelView.text = message

        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            labelView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -120),
            labelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            labelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            labelView.heightAnchor.constraint(equalToConstant: 200),

            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.2),
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.2),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 30)
        ])
    }
}
