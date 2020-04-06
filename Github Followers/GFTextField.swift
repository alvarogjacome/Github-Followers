//
//  GFTextField.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 05/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

class GFTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configuration() {
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor

        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = .preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12

        returnKeyType = .go

        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no

        placeholder = "Enter a username"
    }
}
