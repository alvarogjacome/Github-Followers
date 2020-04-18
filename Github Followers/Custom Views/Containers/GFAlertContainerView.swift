//
//  GFAlertContainerView.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 18/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

final class GFAlertContainerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 16
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
}
