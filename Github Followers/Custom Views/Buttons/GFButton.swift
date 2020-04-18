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

    convenience init(backgroundColor: UIColor, title: String? = nil) {
        self.init(frame: .zero)

        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }

    private func configuration() {
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
    }

    func set(backgroundColor: UIColor, title: String? = nil) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
