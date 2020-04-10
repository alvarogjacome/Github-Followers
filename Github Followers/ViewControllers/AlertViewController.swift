//
//  AlertViewController.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 07/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    let alertContainer = UIView()

    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let bodyLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemRed)

    private var alertTitle: String?
    private var alertMessage: String?
    private var alertButtonText: String?

    let padding: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)

        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
    }

    init(title: String, message: String, textButton: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.alertMessage = message
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureContainerView() {
        view.addSubview(alertContainer)
        alertContainer.layer.borderColor = UIColor.white.cgColor
        alertContainer.layer.borderWidth = 2
        alertContainer.layer.cornerRadius = 16
        alertContainer.backgroundColor = .systemBackground
        alertContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            alertContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertContainer.widthAnchor.constraint(equalToConstant: 280),
            alertContainer.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func configureTitleLabel() {
        alertContainer.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: alertContainer.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    private func configureActionButton() {
        alertContainer.addSubview(actionButton)
        actionButton.setTitle(alertButtonText ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)

        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: alertContainer.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func configureBodyLabel() {
        alertContainer.addSubview(bodyLabel)
        bodyLabel.text = alertMessage ?? "Unable to complete request."
        bodyLabel.numberOfLines = 4

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
