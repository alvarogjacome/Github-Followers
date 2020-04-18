//
//  UIViewController+Extension.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 07/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var loaderView: UIView!

extension UIViewController {
    func presentGFAlertViewController(title: String, message: String, textButton: String) {
        DispatchQueue.main.async {
            let alertViewController = AlertViewController(title: title, message: message, textButton: textButton)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }

    func showLoader() {
        loaderView = UIView(frame: view.bounds)
        view.addSubview(loaderView)
        loaderView.backgroundColor = .secondarySystemBackground
        loaderView.alpha = 0

        UIView.animate(withDuration: 0.25) {
            loaderView.alpha = 0.6
        }

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loaderView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor)
        ])

        activityIndicator.startAnimating()
    }

    func hideLoader() {
        DispatchQueue.main.sync {
            loaderView.removeFromSuperview()
            loaderView = nil
        }
    }

    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }

    func presentSafariViewController(with url: URL){
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true)
    }
}
