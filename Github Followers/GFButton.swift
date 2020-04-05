//
//  GFButton.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 05/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

class GFButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)

        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)

        configuration()
    }

    private func configuration() {
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
    }
}