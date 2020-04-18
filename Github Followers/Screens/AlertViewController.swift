//
//  AlertViewController.swift
//  Github Followers
//
//  Created by Álvaro Gutierrez on 07/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

final class AlertViewController: UIViewController {
    private let alertContainer = GFAlertContainerView()
    private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let bodyLabel = GFBodyLabel(textAlignment: .center)
    private let actionButton = GFButton(backgroundColor: .systemRed)

    init(title: String, message: String, textButton: String) {
        super.init(nibName: nil, bundle: nil)

        configureTitleLabel(title: title)
        configureActionButton(textButton: textButton)
        configureBodyLabel(message: message)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)

        layoutAlertContainer()
        layoutTitleLabel()
        layoutButton()
        layoutBodyLabel()
    }

    private func layoutAlertContainer() {
        view.addSubview(alertContainer)

        NSLayoutConstraint.activate([
            alertContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertContainer.widthAnchor.constraint(equalToConstant: 280),
            alertContainer.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func configureTitleLabel(title: String) {
        titleLabel.text = title
    }

    private func layoutTitleLabel() {
        let padding: CGFloat = 20

        alertContainer.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: alertContainer.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    private func configureActionButton(textButton: String) {
        actionButton.setTitle(textButton, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
    }

    private func layoutButton() {
        let padding: CGFloat = 20

        alertContainer.addSubview(actionButton)

        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: alertContainer.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func configureBodyLabel(message: String) {
        bodyLabel.text = message
        bodyLabel.numberOfLines = 4
    }

    private func layoutBodyLabel() {
        let padding: CGFloat = 20

        alertContainer.addSubview(bodyLabel)

        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor, constant: -padding),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }

    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}
