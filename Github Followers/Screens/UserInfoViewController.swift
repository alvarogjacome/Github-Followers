//
//  UserInfoViewController.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 13/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

protocol UserInfoViewControllerDelegate: class {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoViewController: UIViewController {
    let headerView = UIView()
    let itemViewOne = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    let itemViewTwo = UIView()

    var follower: Follower!
    weak var delegate: FollowerListViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavBar()
        layoutInterface()
        getUserInfo()
    }

    private func configureNavBar() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        navigationItem.setRightBarButton(closeButton, animated: true)
        title = follower.login
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }

    private func getUserInfo() {
        NetworkManager.shared.getUser(username: follower.login) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            case .failure(let error):
                self.presentGFAlertViewController(title: "Something went wrong", message: error.rawValue, textButton: "OK")
            }
        }
    }

    private func configureUIElements(with user: User) {
        addChild(viewController: GFUserInfoHeaderViewController(user: user), to: headerView)

        let repoViewController = GFRepoItemViewController(user: user)
        repoViewController.delegate = self
        addChild(viewController: repoViewController, to: itemViewOne)

        let followerViewController = GFFollowerViewController(user: user)
        followerViewController.delegate = self
        addChild(viewController: followerViewController, to: itemViewTwo)

        dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }

    private func layoutInterface() {
        let views = [headerView, itemViewOne, itemViewTwo, dateLabel]

        views.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),

            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    private func addChild(viewController: UIViewController, to containerView: UIView) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.didMove(toParent: self)
    }

    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}

extension UserInfoViewController: UserInfoViewControllerDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertViewController(title: "Invalid URL", message: "The url is invalid", textButton: "OK")
            return
        }
        presentSafariViewController(with: url)
    }

    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertViewController(title: "No followers", message: "This user has no followers. What a shame 😢", textButton: "OK")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
